import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission_3/provider/database_provider.dart';
import 'package:restaurant_submission_3/provider/detail_restaurant_provider.dart';
import 'package:restaurant_submission_3/provider/post_review_provider.dart';
import 'package:restaurant_submission_3/provider/preferences_provider.dart';
import 'package:restaurant_submission_3/provider/restaurant_list_provider.dart';
import 'package:restaurant_submission_3/provider/schedule_provider.dart';
import 'package:restaurant_submission_3/provider/search_restaurant_provider.dart';
import 'package:restaurant_submission_3/routing/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'common/background_service.dart';
import 'data/local/database_helper.dart';
import 'data/network/api/api_service.dart';
import 'data/notification/notification_helper.dart';
import 'data/preferences/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for Flutter (works for both mobile and web)
  await Hive.initFlutter();
  await Hive.openBox('favoritesBox');

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  // Platform-specific initialization
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      // Initialize Android-specific background service and notifications
      service.initializeIsolate();
      await AndroidAlarmManager.initialize();
      await _initializeNotifications(notificationHelper);
    } else if (Platform.isIOS) {
      // Initialize iOS-specific notifications
      await _initializeNotifications(notificationHelper);
    }  // Initialize database factory for desktop (Windows, macOS, Linux)
  } else {
    // Web specific logic
    print("This feature is coming soon");
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

Future<void> _initializeNotifications(NotificationHelper notificationHelper) async {
  // Initialize notifications for Android/iOS
  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  // Request notification permissions if denied
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        ChangeNotifierProvider<DatabaseProvider>(
            create: (context) => DatabaseProvider(
                databaseHelper: DatabaseHelper()
            )
        ),
        ChangeNotifierProvider<PostReviewProvider>(
            create: (context) => PostReviewProvider(
                apiService: ApiService()
            )
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
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