import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission_3/theme/text_style.dart';
import '../component/custom_dialog.dart';
import '../component/restaurant_app_bar.dart';
import '../component/snackbar.dart';
import '../provider/preferences_provider.dart';
import '../provider/schedule_provider.dart';
import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class SettingRestaurantScreen extends StatelessWidget{
  static const routeName = '/setting';
  const SettingRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check the screen width
          if (constraints.maxWidth < 600) {
            // Use BottomNavigationBar for screens less than 600 pixels wide (mobile)
            return _buildMobileLayout(context);
          } else {
            // Use NavigationRail for larger screens (tablet, web)
            return _buildTabletLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p16,horizontal: Sizes.p16),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppThemes.grey,
                      ),
                    ),
                    Gap.h16,
                    Text(
                        "Atifa Fiorenza",
                        style: AppThemes.headline3.darkGrey
                    ),
                    Text(
                        "atifafiorenza24@gmail.com",
                        style: AppThemes.text1.grey
                    ),
                    Gap.h16,
                    Consumer<PreferencesProvider>(
                        builder: (context, provider, child) {
                          return ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                title: const Text('Dark Theme'),
                                trailing: Switch.adaptive(
                                  value: provider.isDarkTheme,
                                  onChanged: (value) {
                                    provider.setDarkTheme(value);

                                    if(value){
                                      Snackbar.show(context, 'Dark Theme has been on');
                                    }else{
                                      Snackbar.show(context, 'Dark Theme has been off');
                                    }
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Restaurant Notification'),
                                trailing: Consumer<SchedulingProvider>(
                                    builder: (context, scheduled, _) {
                                      return Switch.adaptive(
                                        value: provider.isDailyReminderActive,
                                        onChanged: (value) async {
                                          if (Platform.isIOS) {
                                            customDialog(context);
                                          } else {
                                            bool success = await scheduled.scheduledNotification(value);
                                            provider.setDailyReminder(value);

                                            // Show snackbar based on the success of scheduling
                                            if (success) {
                                              Snackbar.show(context, 'Daily reminder has been on');
                                            } else {
                                              Snackbar.show(context, 'Daily reminder has been of');
                                            }
                                          }
                                        },
                                      );
                                    }),
                              ),
                            ],
                          );
                        }
                    )
                  ],
                )
              ],
            )
        )
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const RestaurantAppBar(),
            backgroundColor: Colors.white,
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p16,horizontal: Sizes.p16),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppThemes.grey,
                      ),
                    ),
                    Gap.h16,
                    Text(
                        "Atifa Fiorenza",
                        style: AppThemes.headline3.darkGrey
                    ),
                    Text(
                        "atifafiorenza24@gmail.com",
                        style: AppThemes.text1.grey
                    ),
                    Consumer<PreferencesProvider>(
                        builder: (context, provider, child) {
                          return ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                title: const Text('Daily Reminder'),
                                trailing: Consumer<SchedulingProvider>(
                                    builder: (context, scheduled, _) {
                                      return Switch.adaptive(
                                        value: provider.isDailyReminderActive,
                                        onChanged: (value) async {
                                          if (Platform.isIOS) {
                                            customDialog(context);
                                          } else {
                                            bool success = await scheduled.scheduledNotification(value);
                                            provider.setDailyReminder(value);

                                            // Show snackbar based on the success of scheduling
                                            if (success) {
                                              Snackbar.show(context, 'Daily reminder has been on');
                                            } else {
                                              Snackbar.show(context, 'Daily reminder has been of');
                                            }
                                          }
                                        },
                                      );
                                    }),
                              ),
                            ],
                          );
                        }
                    )
                  ],
                )
              ],
            )
        )
    );
  }

}
