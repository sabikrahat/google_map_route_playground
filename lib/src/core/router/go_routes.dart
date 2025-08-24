import 'package:go_router/go_router.dart';
import '../../features/home/view/home.dart';

import '../../features/settings/view/setting_view.dart';
import '../shared/page_not_found/page_not_found.dart';
import 'app_routes.dart';

final GoRouter goRouter = GoRouter(
  // debugLogDiagnostics: !kReleaseMode,
  initialLocation: AppRoutes.homeRoute,
  errorBuilder: (_, _) => const KPageNotFound(error: '404 - Page not found!'),
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.settingsRoute,
      name: SettingsView.name,
      builder: (_, _) => const SettingsView(),
    ),
    GoRoute(path: AppRoutes.homeRoute, name: HomeView.name, builder: (_, _) => const HomeView()),
  ],
);
