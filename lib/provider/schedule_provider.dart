import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

import '../common/background_service.dart';
import '../common/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isSchedule = false;
  bool get isSchedule => _isSchedule;

  Future<bool> scheduledNotification(bool value) async {
    _isSchedule = value;
    if (_isSchedule) {
      print('Notification for restaurant recommendation is active');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Notification for restaurant recommendation is nonactive');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}