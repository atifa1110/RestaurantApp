import 'package:flutter/material.dart';
import 'package:restaurant_submission_2/component/category_card.dart';
import 'package:restaurant_submission_2/theme/text_style.dart';
import '../data/network/response/response_detail_restaurant.dart';
import '../theme/app_size.dart';
import '../theme/app_theme.dart';
class RestaurantInformation extends StatelessWidget {
  const RestaurantInformation({
    super.key,
    required this.restaurant,
  });

  final DetailRestaurantResponse restaurant;

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
                style: AppThemes.headline2.bold,
              ),
              Gap.h8,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: AppThemes.grey,
                    size: Sizes.p16,
                  ),
                  Gap.w4,
                  Text(
                    '${restaurant.address}, ${restaurant.city}',
                    style: AppThemes.text2.grey,
                  ),
                ],
              ),
              Gap.h8,
              Wrap(
                children: restaurant.categories
                    .map((item) => CategoryCard(name: item.name))
                    .toList(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.p8,
            horizontal: Sizes.p16,
          ),
          decoration: BoxDecoration(
            color: AppThemes.white,
            borderRadius: BorderRadius.circular(Sizes.p20),
            boxShadow: AppThemes.getSmallShadow(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                color: AppThemes.orange,
              ),
              Gap.w8,
              Text(
                restaurant.rating.toStringAsFixed(1),
                style: AppThemes.headline3.bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}