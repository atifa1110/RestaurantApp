import 'package:flutter/material.dart';
import 'package:restaurant_submission_3/theme/text_style.dart';
import 'package:restaurant_submission_3/theme/app_size.dart';

import '../theme/app_theme.dart';


class CategoryCard extends StatelessWidget {
  final String name;
  const CategoryCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p12,
        vertical: Sizes.p4,
      ),
      margin: const EdgeInsets.only(right: Sizes.p8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.p8),
        color: AppThemes.orange,
      ),
      child: Text(
        name,
        style: AppThemes.subText1.white,
      ),
    );
  }
}