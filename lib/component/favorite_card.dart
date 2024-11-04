import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission_3/theme/text_style.dart';

import '../data/network/api/api_service.dart';
import '../data/network/response/response_detail_restaurant.dart';
import '../provider/database_provider.dart';
import '../routing/app_routes.dart';
import '../routing/extras.dart';
import '../routing/key.dart';
import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class FavoriteRestaurantCard extends StatelessWidget{
  final DetailRestaurantResponse restaurant;

  const FavoriteRestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
        onTap: () {
          context.pushNamed(
            Routes.detailRestaurant.name,
            extra: Extras(
              extras: {
                Keys.restaurantId: restaurant.id,
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(Sizes.p8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.p16),
            color: colorScheme.surfaceContainerHigh,
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: restaurant.pictureId,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                              '${ApiService().smallImage(restaurant.pictureId)}',
                              fit: BoxFit.cover,
                              width: 120,
                              height: 110,
                              errorBuilder: (_, __, ___) {
                                return const Center(
                                    child: Icon(Icons.error)
                                );
                              }
                          ),
                        ),
                      ),
                      Positioned(
                        height: 35,
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6.0,left: 4.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                            decoration: BoxDecoration(
                              color: colorScheme.onSurfaceVariant,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: AppThemes.getSmallShadow(),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Gap.w8,
                                Flexible(  // Added Flexible here to prevent overflow
                                  child: Text(
                                    restaurant.rating.toStringAsFixed(1),
                                    style: AppThemes.text2.copyWith(
                                        color: colorScheme.surfaceVariant,
                                        fontWeight: FontWeight.w600
                                    ),
                                    overflow: TextOverflow.ellipsis, // Avoid text overflow
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap.w16,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: AppThemes.text1.copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: colorScheme.onSecondaryContainer,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.city,
                          style: AppThemes.subText1.copyWith(
                              color: colorScheme.onSecondaryContainer
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      restaurant.description,
                      style: AppThemes.subText1.copyWith(
                          color: colorScheme.onSecondaryContainer
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Gap.w8,
              Consumer<DatabaseProvider>(
                  builder: (context, provider, child) =>
                      FutureBuilder<bool?>(
                          future: provider.isFavorite(restaurant.id),
                          builder: (context, snapshot) {
                            bool isFavorite = snapshot.data ??
                                false;
                            return IconButton(
                              icon: Icon(isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                                  color: isFavorite
                                      ? Colors.red
                                      : Colors.grey),
                              onPressed: () {
                                provider.removeFavorite(
                                    restaurant.id);
                              },
                            );
                          }
                      )
              ),
            ],
          ),
        )
    );
  }
}