import 'package:flutter/material.dart';
import 'package:restaurant_submission_2/theme/text_style.dart';
import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class RestaurantAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RestaurantAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align the text to the left
          children: [
            Text(
              'Cozy Restaurant',
              style: AppThemes.headline3, // Your custom headline style
            ),
            Text(
              'Recommended restaurant for you',
              style: AppThemes.text1.grey, // Your custom grey text style
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Optional: Customize background color
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
