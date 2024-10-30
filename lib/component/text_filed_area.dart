import 'package:flutter/material.dart';
import 'package:restaurant_submission_2/theme/text_style.dart';

import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class TextFieldArea extends StatelessWidget {
  final TextEditingController reviewController;
  final String labelText;
  final String hintText;
  final Function(String? value) onChanged;
  const TextFieldArea({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    required this.reviewController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppThemes.text1),
        Gap.h8,
        TextField(
          controller: reviewController,
          decoration: InputDecoration(
            fillColor: AppThemes.lightGrey,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.p16),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.p16, vertical: Sizes.p12),
            hintText: hintText,
            hintStyle: AppThemes.text2.grey,
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          onChanged: onChanged,
        ),
      ],
    );
  }
}