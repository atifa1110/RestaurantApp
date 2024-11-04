import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final Function(String value) onChanged;
  final Function(String value) onSubmitted;
  final bool autofocus;
  final TextEditingController controller;

  const SearchField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.onSubmitted,
    required this.controller,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      autofocus: autofocus,
      decoration: InputDecoration(
        fillColor: colorScheme.surfaceContainerHigh,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppThemes.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12
        ),
        hintText: hintText,
        hintStyle: AppThemes.text2.copyWith(
          color: colorScheme.onSecondaryContainer
        ),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }


}