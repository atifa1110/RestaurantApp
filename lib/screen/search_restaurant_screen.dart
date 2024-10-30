import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission_2/theme/text_style.dart';
import '../routing/app_routes.dart';
import '../routing/extras.dart';
import '../routing/key.dart';
import '../theme/app_size.dart';
import '../component/lottie_widget.dart';
import '../theme/app_theme.dart';
import '../theme/resource.dart';
import '../component/restaurant_card.dart';
import '../component/search_field.dart';
import '../enum/state.dart';
import '../provider/search_restaurant_provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/searchRestaurant';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();

}

class _SearchScreenState extends State<SearchScreen>{
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Search",style: AppThemes.text1.semiBold),
            backgroundColor: Colors.white,
          ),
          body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p16, vertical: Sizes.p8),
              children: [
                Consumer<SearchRestaurantProvider>(
                    builder: (context, state, _) =>
                        SearchField(
                            hintText: 'What do you want to eat today?',
                            onChanged: (value){
                              if (value.isEmpty) {
                                Provider.of<SearchRestaurantProvider>(context, listen: false)
                                    .clearSearchResults();
                              }else{
                                Provider.of<SearchRestaurantProvider>(context, listen: false)
                                    .getSearchRestaurant(value);
                              }
                            },
                            onSubmitted: (value){
                              if (value.isEmpty) {
                                Provider.of<SearchRestaurantProvider>(context, listen: false)
                                    .clearSearchResults();
                              }else{
                                Provider.of<SearchRestaurantProvider>(context, listen: false)
                                    .getSearchRestaurant(value);
                              }
                            },
                            controller: _searchController
                        )
                ),
                Gap.h16,
                Consumer<SearchRestaurantProvider>(
                  builder: (context, provider, _) {
                    if (provider.state == ResultState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (provider.state == ResultState.hasData) {
                      return Column(
                          children: [
                            ListView.separated(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: provider.restResult.restaurants.length,
                            itemBuilder: (context, index) {
                              var restaurant = provider.restResult.restaurants[index];
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
                                child: RestaurantCard(restaurant: restaurant),
                              );
                            },
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                          ),
                          ]
                      );
                    } else if (provider.state == ResultState.noData) {
                      return LottieWidget(
                        assets: Resources.lottieEmptySearch,
                        description: provider.message,
                        subtitle: "Sorry, there are no results for this search, \nplease try again!",
                      );
                    } else if (provider.state == ResultState.error) {
                      return LottieWidget(
                        assets: Resources.lottieError,
                        description: 'No Result',
                        subtitle: provider.message,
                      );
                    } else {
                      return const Center(child: Text('Search for a restaurant'));
                    }
                  },
                ),
              ]
          )
    );
  }
}