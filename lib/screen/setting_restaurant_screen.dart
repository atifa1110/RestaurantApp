import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission_2/theme/text_style.dart';
import '../component/restaurant_app_bar.dart';
import '../component/snackbar.dart';
import '../provider/preferences_provider.dart';
import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class SettingRestaurantScreen extends StatelessWidget{
  static const routeName = '/settingRestaurant';
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
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.onSecondary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) ,
            ),
            backgroundColor: colorScheme.onSecondary,
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
                      style: AppThemes.headline3.copyWith(
                        color: colorScheme.onSecondaryContainer,
                      ),
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
                                title: Text('Dark Theme',
                                  style: AppThemes.text1.copyWith(
                                    color: colorScheme.onSecondaryContainer,
                                  ),
                                ),
                                trailing: Switch.adaptive(
                                  activeColor: Colors.green,
                                  activeTrackColor: Colors.greenAccent,
                                  inactiveThumbColor: Colors.grey,
                                  inactiveTrackColor: Colors.black12,
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
    final colorScheme = Theme.of(context).colorScheme;
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
                    Gap.h16,
                    Consumer<PreferencesProvider>(
                        builder: (context, provider, child) {
                          return ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                title: Text('Dark Theme',
                                  style: AppThemes.text1.copyWith(
                                    color: colorScheme.onSecondaryContainer,
                                  ),
                                ),
                                trailing: Switch.adaptive(
                                  activeColor: Colors.green,
                                  activeTrackColor: Colors.greenAccent,
                                  inactiveThumbColor: Colors.grey,
                                  inactiveTrackColor: Colors.black12,
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
