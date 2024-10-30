import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_submission_2/theme/text_style.dart';
import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({
    super.key,
    required this.assets,
    this.description,
    this.subtitle,
  });

  final String assets;
  final String? description;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
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
                  style: AppThemes.headline3.darkGrey,
                ),
                Text(
                  subtitle ?? "Empty",
                  textAlign: TextAlign.center,
                  style: AppThemes.text1.grey,
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