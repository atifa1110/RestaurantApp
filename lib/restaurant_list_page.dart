import 'package:flutter/material.dart';
import 'package:restaurant_submission_1/restaurant.dart';
import 'package:restaurant_submission_1/restaurant_app_bar.dart';
import 'package:restaurant_submission_1/restaurant_card.dart';
import 'package:restaurant_submission_1/restaurant_detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const RestaurantAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
                builder: (context, snapshot) {
                  var restaurants = parseRestaurant(snapshot.data);
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = restaurants[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                              arguments: restaurant);
                        },
                        child: RestaurantCard(restaurant: restaurant)
                      );
                    }, separatorBuilder: (context, index) => const SizedBox(height: 12),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
