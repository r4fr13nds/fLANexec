import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    let channel = FlutterMethodChannel(name: "com.r4fr13nds.flanexec/smb", binaryMessenger: flutterViewController.engine.binaryMessenger)
    channel.setMethodCallHandler { (call, result) in
      switch call.method {
      case "authenticate":
          self.handleAuthenticate(call: call, result: result)
      case "enumerateShares":
          self.handleEnumerateShares(call: call, result: result)
      default:
          result(FlutterMethodNotImplemented)
      }
    }

    super.awakeFromNib()
  }

  private func handleAuthenticate(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let host = args["host"] as? String,
          let username = args["username"] as? String,
          let password = args["password"] as? String else {
      result(FlutterError(code: "INVALID_ARGS", message: "Missing arguments", details: nil))
      return
    }

    let task = Process()
    // Try to find smbclient in common locations
    let paths = [
        "/usr/bin/smbclient",
        "/opt/homebrew/bin/smbclient",
        "/usr/local/bin/smbclient"
    ]

    let fm = FileManager.default
    var executablePath: String? = nil

    for path in paths {
        if fm.fileExists(atPath: path) {
            executablePath = path
            break
        }
    }

    guard let finalPath = executablePath else {
        result([
          "success": false,
          "error": "smbclient not found at standard paths. Found via which: /opt/homebrew/bin/smbclient. Please ensure the app has permission to access it."
        ])
        return
    }

    task.executableURL = URL(fileURLWithPath: finalPath)
    task.arguments = ["-L", "//\(host)", "-U", "\(username)%\(password)", "-c", "quit"]

    let outputPipe = Pipe()
    let errorPipe = Pipe()
    task.standardOutput = outputPipe
    task.standardError = errorPipe

    do {
      try task.run()
      task.waitUntilExit()

      let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
      let output = String(data: outputData, encoding: .utf8) ?? ""

      if task.terminationStatus == 0 {
        // Simple extraction of shares from output
        let lines = output.components(separatedBy: .newlines)
        var shares: [String] = []
        var capture = false
        for line in lines {
            if line.contains("Sharename") { capture = true; continue }
            if line.contains("---------") { continue }
            if line.trimmingCharacters(in: .whitespaces).isEmpty && capture { break }
            if capture {
                let parts = line.split(separator: " ", omittingEmptySubsequences: true)
                if parts.count >= 1 {
                    shares.append(String(parts[0]))
                }
            }
        }

        result([
          "success": true,
          "osVersion": "Shares: \(shares.joined(separator: ", "))"
        ])
      } else {
        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        let errorOutput = String(data: errorData, encoding: .utf8) ?? "Unknown error"
        result([
          "success": false,
          "error": "Auth failed: \(errorOutput)"
        ])
      }
    } catch {
      result([
        "success": false,
        "error": error.localizedDescription
      ])
    }
  }

  private func handleEnumerateShares(call: FlutterMethodCall, result: @escaping FlutterResult) {
      guard let args = call.arguments as? [String: Any],
            let host = args["host"] as? String,
            let username = args["username"] as? String,
            let password = args["password"] as? String else {
          result(FlutterError(code: "INVALID_ARGS", message: "Missing arguments", details: nil))
          return
      }

      let paths = ["/usr/bin/smbclient", "/opt/homebrew/bin/smbclient", "/usr/local/bin/smbclient"]
      let fm = FileManager.default
      var execPath: String? = nil
      for p in paths { if fm.fileExists(atPath: p) { execPath = p; break } }

      guard let finalPath = execPath else {
          result(FlutterError(code: "NOT_FOUND", message: "smbclient not found", details: nil))
          return
      }

      let task = Process()
      task.executableURL = URL(fileURLWithPath: finalPath)
      task.arguments = ["-L", "//\(host)", "-U", "\(username)%\(password)", "-c", "quit"]

      let pipe = Pipe()
      task.standardOutput = pipe

      do {
          try task.run()
          task.waitUntilExit()
          let data = pipe.fileHandleForReading.readDataToEndOfFile()
          let output = String(data: data, encoding: .utf8) ?? ""

          let lines = output.components(separatedBy: .newlines)
          var shares: [[String: String]] = []
          var capture = false
          for line in lines {
              if line.contains("Sharename") { capture = true; continue }
              if line.contains("---------") { continue }
              if line.trimmingCharacters(in: .whitespaces).isEmpty && capture { break }
              if capture {
                  let parts = line.split(separator: " ", omittingEmptySubsequences: true)
                  if parts.count >= 2 {
                      shares.append([
                        "name": String(parts[0]),
                        "type": String(parts[1])
                      ])
                  }
              }
          }
          result(shares)
      } catch {
          result(FlutterError(code: "EXEC_ERROR", message: error.localizedDescription, details: nil))
      }
  }
}
