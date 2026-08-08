import 'package:flanexec/features/credentials/screens/credentials_screen.dart';
import 'package:flanexec/features/discovery/screens/discovery_screen.dart';
import 'package:flanexec/features/service_info/screens/service_info_screen.dart';
import 'package:flanexec/features/settings/screens/settings_screen.dart';
import 'package:flanexec/features/shared/widgets/log_panel.dart';
import 'package:flanexec/core/utils/logger.dart';
import 'package:flanexec/features/discovery/providers/discovery_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/discovery',
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/discovery',
                builder: (context, state) => const DiscoveryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/credentials',
                builder: (context, state) => const CredentialsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/service_info',
                builder: (context, state) => const ServiceInfoScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class AppScaffold extends HookConsumerWidget {
  const AppScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final isLogVisible = ref.watch(logPanelVisibleProvider);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.digit1, meta: true): () => navigationShell.goBranch(0),
        const SingleActivator(LogicalKeyboardKey.digit2, meta: true): () => navigationShell.goBranch(1),
        const SingleActivator(LogicalKeyboardKey.digit3, meta: true): () => navigationShell.goBranch(2),
        const SingleActivator(LogicalKeyboardKey.digit4, meta: true): () => navigationShell.goBranch(3),
        const SingleActivator(LogicalKeyboardKey.keyR, meta: true): () {
          if (navigationShell.currentIndex == 0) {
            ref.read(discoverySessionProvider.notifier).startScan();
          }
        },
        const SingleActivator(LogicalKeyboardKey.escape): () {
          if (isLogVisible) {
            ref.read(logPanelVisibleProvider.notifier).state = false;
          }
        },
      },
      child: Scaffold(
        appBar: isDesktop ? AppBar(
          title: const Text('fLANexec'),
          actions: [
            IconButton(
              icon: Icon(isLogVisible ? Icons.terminal : Icons.terminal_outlined),
              onPressed: () => ref.read(logPanelVisibleProvider.notifier).state = !isLogVisible,
              tooltip: 'Toggle Network Logs',
            ),
            const SizedBox(width: 8),
          ],
        ) : null,
        body: Stack(
          children: [
            _buildMainLayout(context, isDesktop),
            const LogPanel(),
          ],
        ),
        bottomNavigationBar: !isDesktop
            ? NavigationBar(
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: (index) => navigationShell.goBranch(index),
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.search), label: 'Discovery'),
                  NavigationDestination(icon: Icon(Icons.security), label: 'Auth'),
                  NavigationDestination(icon: Icon(Icons.info_outline), label: 'Service'),
                  NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildMainLayout(BuildContext context, bool isDesktop) {
    if (isDesktop) {
      return Row(
        children: [
          NavigationRail(
            extended: MediaQuery.of(context).size.width > 1200,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.search), label: Text('Discovery')),
              NavigationRailDestination(icon: Icon(Icons.security), label: Text('Authentication')),
              NavigationRailDestination(icon: Icon(Icons.info_outline), label: Text('Service Info')),
              NavigationRailDestination(icon: Icon(Icons.settings_outlined), label: Text('Settings')),
            ],
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => navigationShell.goBranch(index),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: navigationShell),
        ],
      );
    }
    return navigationShell;
  }
}

class NetScanApp extends ConsumerWidget {
  const NetScanApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'fLANexec',
      themeMode: ThemeMode.dark, // Default to dark mode
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          isDense: true,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          isDense: true,
        ),
      ),
      routerConfig: router,
    );
  }
}

// Global Mono extension for consistency
extension TextThemeExtension on TextTheme {
  TextStyle get mono => GoogleFonts.jetBrainsMono(
        fontSize: bodyMedium?.fontSize,
        fontWeight: bodyMedium?.fontWeight,
      );
  
  TextStyle get monoSmall => GoogleFonts.jetBrainsMono(
        fontSize: bodySmall?.fontSize,
        fontWeight: bodySmall?.fontWeight,
      );
}
