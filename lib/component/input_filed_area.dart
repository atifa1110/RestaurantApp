import 'package:flutter/material.dart';
import 'package:restaurant_submission_2/theme/text_style.dart';

import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController nameController;
  final String labelText;
  final String hintText;
  final Function(String? value) onChanged;
  const InputTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppThemes.text1.copyWith(
            color: colorScheme.onSecondaryContainer
        )),
        Gap.h8,
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            fillColor: colorScheme.surfaceContainerHigh,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.p20),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.p16, vertical: Sizes.p12),
            hintText: hintText,
            hintStyle: AppThemes.text2.copyWith(
                color: colorScheme.onSecondaryContainer
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}