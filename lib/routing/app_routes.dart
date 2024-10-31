import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screen/detail_restaurant_screen.dart';
import '../screen/favorite_restaurant_screen.dart';
import '../screen/home__restaurant_screen.dart';
import '../screen/main_restaurant_screen.dart';
import '../screen/review_restaurant_screen.dart';
import '../screen/search_restaurant_screen.dart';
import '../screen/setting_restaurant_screen.dart';
import '../screen/splash_screen.dart';
import 'error_page.dart';
import 'extras.dart';
import 'key.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum Routes {
  splash,
  home,
  favorite,
  setting,
  detailRestaurant,
  searchRestaurant,
  reviewCustomer
}

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  errorPageBuilder: (context, state) => _navigate(
    context,
    state,
    ErrorPage(
      error: state.error,
    ),
  ),
  routes: [
    GoRoute(
      path: '/splash',
      parentNavigatorKey: _rootNavigatorKey,
      name: Routes.splash.name,
      pageBuilder: (context, state) =>
          _navigate(context, state, const SplashScreen()),
    ),

    // ShellRoute for bottom navigation pages (Home, Favorite, Setting)
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainRestaurantScreen(child: child); // Bottom navigation wrapper
      },
      routes: [
        GoRoute(
            path: '/home',
            parentNavigatorKey: _shellNavigatorKey,
            name: Routes.home.name,
            pageBuilder: (context, state) =>
                _navigate(context, state, const HomeScreen()),
            routes: [
              // Detail and Search outside of bottom navigation
              GoRoute(
                path: 'detailRestaurant',
                parentNavigatorKey: _rootNavigatorKey,
                name: Routes.detailRestaurant.name,
                pageBuilder: (context, state) {
                  final extras = (state.extra as Extras).extras;
                  final restaurantId = extras[Keys.restaurantId] as String;
                  return _navigate(
                    context,
                    state,
                    DetailRestaurantScreen(
                      restaurantId: restaurantId,
                      isBackButtonShow: true,
                    ),
                  );
                },
              ),

              GoRoute(
                path: 'searchRestaurant',
                parentNavigatorKey: _rootNavigatorKey,
                name: Routes.searchRestaurant.name,
                pageBuilder: (context, state) =>
                    _navigate(context, state, const SearchScreen()),
              ),

              GoRoute(
                  path: 'reviewCustomer',
                  parentNavigatorKey: _rootNavigatorKey,
                  name: Routes.reviewCustomer.name,
                  pageBuilder: (context, state) {
                    final extras = (state.extra as Extras).extras;
                    final restaurantId = extras[Keys.restaurantId] as String;
                    return _navigate(context, state,
                        ReviewRestaurantScreen(restaurantId: restaurantId)
                    );
                  }
              ),
            ]
        ),

        GoRoute(
          path: '/favorite',
          parentNavigatorKey: _shellNavigatorKey,
          name: Routes.favorite.name,
          pageBuilder: (context, state) =>
              _navigate(context, state, const FavoriteRestaurantScreen()),
        ),
        GoRoute(
          path: '/setting',
          parentNavigatorKey: _shellNavigatorKey,
          name: Routes.setting.name,
          pageBuilder: (context, state) =>
              _navigate(context, state, const SettingRestaurantScreen()),
        ),
      ],
    ),
  ],
);

// Helper function to navigate
Page<void> _navigate(BuildContext context, GoRouterState state, Widget screen) {
  return MaterialPage<void>(
    key: state.pageKey,
    restorationId: state.pageKey.value,
    child: screen,
  );
}
