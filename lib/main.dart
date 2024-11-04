import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission_2/data/preferences/preferences_helper.dart';
import 'package:restaurant_submission_2/provider/detail_restaurant_provider.dart';
import 'package:restaurant_submission_2/provider/post_review_provider.dart';
import 'package:restaurant_submission_2/provider/preferences_provider.dart';
import 'package:restaurant_submission_2/provider/restaurant_list_provider.dart';
import 'package:restaurant_submission_2/provider/search_restaurant_provider.dart';
import 'package:restaurant_submission_2/routing/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/network/api/api_service.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<RestaurantListProvider>(
              create: (context) => RestaurantListProvider(
                apiService: ApiService(),
              ),
            ),
            ChangeNotifierProvider<SearchRestaurantProvider>(
              create: (context) => SearchRestaurantProvider(
                apiService: ApiService(),
              ),
            ),
            ChangeNotifierProvider<PostReviewProvider>(
                create: (context) => PostReviewProvider(
                    apiService: ApiService()
                )
            ),
            ChangeNotifierProvider(
              create: (_) => DetailRestaurantProvider(
                  apiService: ApiService()
              ),
            ),
            ChangeNotifierProvider(
                create: (_) => PreferencesProvider(
                    preferencesHelper: PreferencesHelper(
                        sharedPreferences: SharedPreferences.getInstance()
                    )
                )
            )
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesProvider = Provider.of<PreferencesProvider>(context);

    return MaterialApp.router(
      title: 'Restaurant',
      theme: preferencesProvider.themeData,
      debugShowCheckedModeBanner: false,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      routerDelegate: goRouter.routerDelegate,
    );
  }
}

