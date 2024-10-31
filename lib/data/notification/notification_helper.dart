import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../../routing/navigation.dart';
import '../network/response/response_restaurant.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  @pragma('vm:entry-point')
  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin,
      ) async {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        final payload = details.payload;
        if (payload != null) {
          if (kDebugMode) {
            print('notification payload: $payload');
          }
          selectNotificationSubject.add(payload);
        }
      },
    );
  }

  Future<void> showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin,
      RestaurantListResponse restaurantListResult) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "restaurant app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Restaurant App</b>";
    var restaurantList = restaurantListResult.restaurants;
    var randomIndex = Random().nextInt(restaurantList.length);
    var restaurantTitle = restaurantList[randomIndex].name;

    var payload = json.encode({
      'restaurants': restaurantListResult.toJson(),
      'randomIndex': randomIndex,
    });

    await flutterLocalNotificationPlugin.show(
      0,
      titleNotification,
      restaurantTitle,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = json.decode(payload);
      var restaurantListResult =
      RestaurantListResponse.fromJson(data['restaurants']);
      var randomIndex = data['randomIndex'];
      var restaurant = restaurantListResult.restaurants[randomIndex];
      Navigation.intentWithData(route, restaurant);
    });
  }
}