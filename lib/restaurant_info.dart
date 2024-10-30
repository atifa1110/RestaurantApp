import 'package:flutter/material.dart';
import 'package:restaurant_submission_1/restaurant.dart';

import 'app_theme.dart';

class RestaurantInformation extends StatelessWidget {
  const RestaurantInformation({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: AppThemes.headline2,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: AppThemes.grey,
                    size: 16,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurant.city,
                    style: AppThemes.text2,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: AppThemes.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppThemes.getSmallShadow(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                color: AppThemes.orange,
              ),
              const SizedBox(height: 8),
              Text(
                restaurant.rating.toStringAsFixed(1),
                style: AppThemes.headline3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}