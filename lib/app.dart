import 'package:flanexec/features/credentials/screens/credentials_screen.dart';
import 'package:flanexec/features/discovery/screens/discovery_screen.dart';
import 'package:flanexec/features/service_info/screens/service_info_screen.dart';
import 'package:flutter/material.dart';
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

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: size.width > 1200,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.search),
                  label: Text('Discovery'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.vpn_key),
                  label: Text('Credentials'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info),
                  label: Text('Service Info'),
                ),
              ],
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) => navigationShell.goBranch(index),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Discovery',
          ),
          NavigationDestination(
            icon: Icon(Icons.vpn_key),
            label: 'Credentials',
          ),
          NavigationDestination(
            icon: Icon(Icons.info),
            label: 'Service Info',
          ),
        ],
      ),
    );
  }
}

class NetScanApp extends ConsumerWidget {
  const NetScanApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'fLANexec',
      themeMode: ThemeMode.dark, // Default to dark mode
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
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
