import 'package:flutter/material.dart';
import 'package:restaurant_submission_1/restaurant.dart';
import 'package:restaurant_submission_1/restaurant_detail_page.dart';
import 'package:restaurant_submission_1/restaurant_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),
      },
    );
  }
}