import 'package:flanexec/core/networking/pinger.dart';
import 'package:flanexec/core/networking/port_scanner.dart';
import 'package:flanexec/core/networking/ip_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Live network checks — excluded from CI via --exclude-tags=network.
  test('Networking smoke test', () async {
    final localIp = await IpUtils.getLocalIpAddress();
    expect(localIp, isNotNull);

    final pingResult = await Pinger.ping('8.8.8.8');
    expect(pingResult.status, isNot(PingStatus.unreachable));

    final results = await PortScanner.scanPorts('example.com', [80, 443]).toList();
    expect(results, isNotEmpty);
  }, timeout: const Timeout(Duration(minutes: 1)), tags: ['network']);
}
