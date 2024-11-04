import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_submission_3/theme/text_style.dart';
import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({
    super.key,
    required this.assets,
    this.description,
    this.subtitle,
    this.onRefresh
  });

  final String assets;
  final String? description;
  final String? subtitle;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: Sizes.screenHeight(context) * 0.6,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth * 0.7;
          return Center(
            child: description != null
                ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  assets,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                Gap.h8,
                Text(
                  description ?? "Empty",
                  style: AppThemes.headline3.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
                Text(
                  subtitle ?? "Empty",
                  textAlign: TextAlign.center,
                  style: AppThemes.text1.grey,
                ),
                Gap.h16, // Add spacing above the button
                if (onRefresh != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemes.white, // Set background color
                      foregroundColor:AppThemes.black, // Set text color
                      textStyle: AppThemes.text1, // Set text style from AppThemes
                    ),
                    onPressed: onRefresh,
                    child: Text('Refresh', style: AppThemes.text1),
                  ),
              ],
            )
                : Lottie.asset(
              assets,
              width: width,
              fit: BoxFit.fitWidth,
            ),
          );
        },
      ),
    );
  }
}