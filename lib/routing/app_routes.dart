import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screen/detail_restaurant_screen.dart';
import '../screen/home__restaurant_screen.dart';
import '../screen/review_restaurant_screen.dart';
import '../screen/search_restaurant_screen.dart';
import '../screen/splash_screen.dart';
import 'error_page.dart';
import 'extras.dart';
import 'key.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum Routes {
  splash,
  home,
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
      name: Routes.splash.name,
      pageBuilder: (context, state) =>
          _navigate(context, state, const SplashScreen()),
    ),

    GoRoute(
      path: '/home',
      name: Routes.home.name,
      pageBuilder: (context, state) =>
          _navigate(context, state, const HomeScreen()),
      routes: [
        // Detail and Search outside of bottom navigation
        GoRoute(
          path: 'detailRestaurant',
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
          name: Routes.searchRestaurant.name,
          pageBuilder: (context, state) =>
              _navigate(context, state, const SearchScreen()),
        ),

        GoRoute(
            path: 'reviewCustomer',
            name: Routes.reviewCustomer.name,
            pageBuilder: (context, state) {
              final extras = (state.extra as Extras).extras;
              final restaurantId = extras[Keys.restaurantId] as String;
              return _navigate(context, state,
                  ReviewRestaurantScreen(restaurantId: restaurantId)
              );
            }
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
