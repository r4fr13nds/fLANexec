import 'package:flanexec/app.dart';
import 'package:flanexec/features/discovery/widgets/host_detail_sheet.dart';
import 'package:flanexec/features/shared/models/host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HostListTile extends StatelessWidget {
  final Host host;

  const HostListTile({super.key, required this.host});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayName = host.hostname ?? host.netbiosName ?? host.ip;
    final secondaryName = (host.hostname != null || host.netbiosName != null) ? host.ip : null;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: _OsLogo(osType: host.osType, status: host.status, size: 24),
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          children: [
            Text(
              displayName,
              style: theme.textTheme.mono.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            if (host.isDomainController)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'DC',
                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            if (host.domain != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  host.domain!.toUpperCase(),
                  style: TextStyle(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              runSpacing: 2,
              children: [
                if (secondaryName != null)
                  Text(secondaryName, style: theme.textTheme.monoSmall.copyWith(color: Colors.grey)),
                if (host.osVersion != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      host.osVersion!,
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (host.macAddress != null)
                  Text(host.macAddress!, style: theme.textTheme.monoSmall.copyWith(color: Colors.grey, fontSize: 10)),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: host.ports.take(12).map((p) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${p.port}',
                    style: theme.textTheme.monoSmall.copyWith(fontSize: 10),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => HostDetailSheet(host: host),
          );
        },
      ),
    );
  }
}

class _OsLogo extends StatelessWidget {
  final HostOs osType;
  final String status;
  final double size;

  const _OsLogo({
    required this.osType,
    required this.status,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAlive = status == 'alive';
    
    String iconName;
    switch (osType) {
      case HostOs.windows: iconName = 'windows'; break;
      case HostOs.linux: iconName = 'linux'; break;
      case HostOs.macos: iconName = 'apple'; break;
      case HostOs.ios: iconName = 'ios'; break;
      case HostOs.android: iconName = 'android'; break;
      case HostOs.networkDevice: iconName = 'router'; break;
      case HostOs.unknown: iconName = 'unknown'; break;
    }

    final iconColor = isAlive ? theme.colorScheme.primary : theme.disabledColor;

    return SizedBox(
      width: size + 4,
      height: size + 4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: isAlive ? 1.0 : 0.5,
            child: SvgPicture.asset(
              'assets/icons/os/$iconName.svg',
              width: size,
              height: size,
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (context) => Icon(Icons.help_outline, size: size, color: iconColor),
            ),
          ),
          if (isAlive)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.cardColor, width: 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
