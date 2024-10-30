import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_submission_1/menus_card.dart';
import 'package:restaurant_submission_1/restaurant.dart';
import 'package:restaurant_submission_1/restaurant_info.dart';

import 'app_theme.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const  RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(32),
                              ),
                              child: AspectRatio(
                                  aspectRatio: 4 / 3,
                                  child: Image.network(
                                    restaurant.pictureId,
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                          ],
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            RestaurantInformation(restaurant: restaurant),
                            const SizedBox(height: 16),
                            Text("Description",style: AppThemes.headline3),
                            const SizedBox(height: 4),
                            ReadMoreText(
                              restaurant.description,
                              trimLines: 6,
                              textAlign: TextAlign.justify,
                              colorClickableText: AppThemes.green,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              style: AppThemes.text2,
                            ),
                            const SizedBox(height: 16),
                            Text("Foods",style: AppThemes.headline3),
                            const SizedBox(height: 4),
                            SizedBox(
                              height: 150, // Set an appropriate height for the list
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemCount: restaurant.menus.foods.length,
                                itemBuilder: (context, index) {
                                  var menus = restaurant.menus.foods[index];
                                  return MenusCard(names: menus.name);
                                },
                                separatorBuilder: (context, index) => const SizedBox(width: 12),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text("Drinks",style: AppThemes.headline3),
                            const SizedBox(height: 4),
                            SizedBox(
                              height: 150, // Set an appropriate height for the list
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemCount: restaurant.menus.drinks.length,
                                itemBuilder: (context, index) {
                                  var menus = restaurant.menus.drinks[index];
                                  return MenusCard(names: menus.name);
                                },
                                separatorBuilder: (context, index) => const SizedBox(width: 12),
                              ),
                            )
                          ]
                      )
                  )
                ]
            )
        )
    );
  }
}