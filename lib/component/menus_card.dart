import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
class MenusCard extends StatelessWidget {
  final String names;

  const MenusCard({super.key, required this.names});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.fastfood,
            color: Colors.grey,
            size: 48,
          ),
          const SizedBox(height: 8),
          Text(
            names,
            style: AppThemes.text1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'IDR 15.000',
            textAlign: TextAlign.start,
            style: AppThemes.text2,
          ),
        ],
      ),
    );
  }
}