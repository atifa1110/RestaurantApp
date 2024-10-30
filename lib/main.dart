import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission_2/provider/detail_restaurant_provider.dart';
import 'package:restaurant_submission_2/provider/post_review_provider.dart';
import 'package:restaurant_submission_2/provider/restaurant_list_provider.dart';
import 'package:restaurant_submission_2/provider/search_restaurant_provider.dart';
import 'package:restaurant_submission_2/routing/app_routes.dart';
import 'data/network/api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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

      ],
      child: MaterialApp.router(
        title: 'Restaurant',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routeInformationParser: goRouter.routeInformationParser,
        routeInformationProvider: goRouter.routeInformationProvider,
        routerDelegate: goRouter.routerDelegate,
      ),
    );
  }
}

