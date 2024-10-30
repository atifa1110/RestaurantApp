import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routing/app_routes.dart';
import '../theme/app_theme.dart';

class SearchPlaceholder extends StatelessWidget {
  final String hintText;
  const SearchPlaceholder({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.searchRestaurant.name,
        );
      },
      child: AbsorbPointer( // To prevent the tap from affecting the TextField directly
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: AppThemes.lightGrey,
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
            hintText: hintText,
            hintStyle: AppThemes.text2,
          ),
        ),
      ),
    );
  }

}
