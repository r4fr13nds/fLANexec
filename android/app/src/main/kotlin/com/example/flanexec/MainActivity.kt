package com.example.flanexec

import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.hierynomus.smbj.SMBClient
import com.hierynomus.smbj.auth.AuthenticationContext
import com.hierynomus.smbj.session.Session
import com.hierynomus.smbj.connection.Connection
import kotlinx.coroutines.CoroutineScope
import io.flutter.plugin.common.MethodCall
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.flanexec/smb"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "authenticate" -> handleAuthenticate(call, result)
                "enumerateShares" -> handleEnumerateShares(call, result)
                else -> result.notImplemented()
            }
        }
    }

    private fun handleAuthenticate(call: MethodCall, result: MethodChannel.Result) {
        val host = call.argument<String>("host") ?: ""
        val username = call.argument<String>("username") ?: ""
        val password = call.argument<String>("password") ?: ""
        val domain = call.argument<String>("domain")

        CoroutineScope(Dispatchers.IO).launch {
            val client = SMBClient()
            try {
                val connection = client.connect(host)
                val context = AuthenticationContext(username, password.toCharArray(), domain)
                val session = connection.authenticate(context)
                
                withContext(Dispatchers.Main) {
                    result.success(mapOf(
                        "success" to true,
                        "osVersion" to connection.connectionInfo.negotiatedProtocol.name,
                        "netbiosName" to connection.connectionInfo.serverGuid.toString()
                    ))
                }
                session.close()
                connection.close()
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    result.success(mapOf("success" to false, "error" to e.message))
                }
            } finally {
                client.close()
            }
        }
    }

    private fun handleEnumerateShares(call: MethodCall, result: MethodChannel.Result) {
        // Implementation for share enumeration would go here
        result.success(emptyList<Map<String, String>>())
    }
}
