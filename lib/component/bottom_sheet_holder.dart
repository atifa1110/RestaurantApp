import 'package:flutter/material.dart';

import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class BottomSheetHolder extends StatelessWidget {
  const BottomSheetHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.p12),
          color: AppThemes.black,
        ),
        height: Sizes.p4,
        width: Sizes.screenWidth(context) * 0.12,
      ),
    );
  }
}