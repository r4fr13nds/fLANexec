import 'package:flanexec/core/networking/pinger.dart';
import 'package:flanexec/core/networking/port_scanner.dart';
import 'package:flanexec/core/networking/ip_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Networking smoke test', () async {
    print('--- Network Utility Test ---');

    final localIp = await IpUtils.getLocalIpAddress();
    print('Local IP: $localIp');

    print('\n--- Pinging 8.8.8.8 ---');
    final pingResult = await Pinger.ping('8.8.8.8');
    print('Result: $pingResult');

    print('\n--- Scanning example.com (80, 443) ---');
    final scanStream = PortScanner.scanPorts('example.com', [80, 443]);
    await for (final result in scanStream) {
      print('Scan Result: $result');
    }
    
    expect(pingResult.status, isNot(PingStatus.unreachable));
  }, timeout: const Timeout(Duration(minutes: 1)));
}
