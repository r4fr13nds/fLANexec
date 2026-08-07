import 'package:flanexec/core/networking/ip_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IpUtils Validation', () {
    test('isValidIp', () {
      expect(IpUtils.isValidIp('192.168.1.1'), true);
      expect(IpUtils.isValidIp('8.8.8.8'), true);
      expect(IpUtils.isValidIp('256.256.256.256'), false);
      expect(IpUtils.isValidIp('not an ip'), false);
      expect(IpUtils.isValidIp('192.168.1'), false);
    });

    test('isValidCidr', () {
      expect(IpUtils.isValidCidr('192.168.1.0/24'), true);
      expect(IpUtils.isValidCidr('10.0.0.0/8'), true);
      expect(IpUtils.isValidCidr('192.168.1.0/33'), false);
      expect(IpUtils.isValidCidr('192.168.1.0'), false);
      expect(IpUtils.isValidCidr('not a cidr/24'), false);
    });
  });

  group('IpUtils Expansion', () {
    test('/30 expansion (4 IPs total, 2 usable)', () {
      final ips = IpUtils.expandCidr('192.168.1.0/30');
      // .0 network, .3 broadcast. .1 and .2 usable.
      expect(ips.length, 2);
      expect(ips, ['192.168.1.1', '192.168.1.2']);
    });

    test('/24 expansion (256 IPs total, 254 usable)', () {
      final ips = IpUtils.expandCidr('192.168.1.0/24');
      expect(ips.length, 254);
      expect(ips.first, '192.168.1.1');
      expect(ips.last, '192.168.1.254');
    });

    test('/23 expansion (512 IPs total, 510 usable)', () {
      final ips = IpUtils.expandCidr('192.168.0.0/23');
      expect(ips.length, 510);
      expect(ips.first, '192.168.0.1');
      expect(ips.last, '192.168.1.254');
    });

    test('/16 expansion (65536 IPs total, 65534 usable)', () {
      final ips = IpUtils.expandCidr('172.16.0.0/16');
      expect(ips.length, 65534);
      expect(ips.first, '172.16.0.1');
      expect(ips.last, '172.16.255.254');
    });

    test('/32 expansion (1 IP usable)', () {
      final ips = IpUtils.expandCidr('8.8.8.8/32');
      expect(ips.length, 1);
      expect(ips.first, '8.8.8.8');
    });
    
    test('/31 expansion (2 IPs usable)', () {
      final ips = IpUtils.expandCidr('192.168.1.0/31');
      expect(ips.length, 2);
      expect(ips, ['192.168.1.0', '192.168.1.1']);
    });
  });
}
