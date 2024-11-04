import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_submission_2/theme/text_style.dart';
import '../routing/app_routes.dart';
import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class RestaurantAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RestaurantAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
        title: Padding(
          padding: const EdgeInsets.all(Sizes.p8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align the text to the left
            children: [
              Text(
                'Cozy Restaurant',
                style: AppThemes.headline3.copyWith(
                    color: colorScheme.onSecondaryContainer
                ), // Your custom headline style
              ),
              Text(
                'Recommended restaurant for you',
                style: AppThemes.text1.grey, // Your custom grey text style
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page or perform any action
              context.pushNamed(
                Routes.settingRestaurant.name,
              );
            },
          ),
        ],
        backgroundColor: colorScheme.onSecondary // Optional: Customize background color
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
