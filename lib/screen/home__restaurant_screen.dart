import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../common/state.dart';
import '../theme/app_size.dart';
import '../component/lottie_widget.dart';
import '../theme/resource.dart';
import '../component/restaurant_app_bar.dart';
import '../component/restaurant_card.dart';
import '../component/search_placeholder.dart';
import '../provider/detail_restaurant_provider.dart';
import '../provider/restaurant_list_provider.dart';
import '../routing/app_routes.dart';
import '../routing/extras.dart';
import '../routing/key.dart';
import 'detail_restaurant_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState  extends State<HomeScreen> {

  var _selectedRestaurantId; // Variable to hold the selected restaurant ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check the screen width
          if (constraints.maxWidth < 600) {
            // Use BottomNavigationBar for screens less than 600 pixels wide (mobile)
            return _buildMobileLayout(context);
          } else {
            // Use NavigationRail for larger screens (tablet, web)
            return _buildTabletLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
        child: Scaffold(
            backgroundColor: colorScheme.onSecondary,
            body: ListView(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16,horizontal: Sizes.p16),
                children: [
                  const SearchPlaceholder(hintText: 'What do you want to eat today?'),
                  Gap.h16,
                  Consumer<RestaurantListProvider>(
                      builder: (context, state, _) {
                        if (state.state == ResultState.loading) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state.state == ResultState.hasData) {
                          return Column(
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: state.restResult.restaurants.length,
                                itemBuilder: (context, index) {
                                  var restaurant = state.restResult.restaurants[index];
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
                            ],
                          );
                        } else if (state.state == ResultState.noData) {
                          return LottieWidget(
                            assets: Resources.lottieEmpty,
                            description: 'No Result',
                            subtitle: state.message,
                            onRefresh: (){
                              // Call the refresh method on RestaurantProvider
                              context.read<RestaurantListProvider>().refresh();
                            },
                          );
                        } else if (state.state == ResultState.error) {
                          return LottieWidget(
                            assets: Resources.lottieError,
                            description: 'No Result',
                            subtitle: state.message,
                              onRefresh: (){
                                // Call the refresh method on RestaurantProvider
                                context.read<RestaurantListProvider>().refresh();
                              }
                          );
                        } else {
                          return const Center(
                            child: Material(
                              child: Text('Unexpected Error'),
                            ),
                          );
                        }
                      }
                  )
                ]
            )
        )
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        // Left side: List of restaurants
        Expanded(
          child: SafeArea(
            child: Scaffold(
              appBar: const RestaurantAppBar(), // Your custom AppBar
              backgroundColor: colorScheme.onSecondary,
              body: ListView(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16, horizontal: Sizes.p24),
                children: [
                  const SearchPlaceholder(hintText: 'What do you want to eat today?'),
                  Gap.h16,
                  Consumer<RestaurantListProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.loading) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state.state == ResultState.hasData) {
                        return Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: state.restResult.restaurants.length,
                              itemBuilder: (context, index) {
                                var restaurant = state.restResult.restaurants[index];
                                return GestureDetector(
                                  onTap: () {
                                    print("Selected Restaurant Id: ${restaurant.id}");
                                    setState(() {
                                      // Update the selected restaurant ID
                                      _selectedRestaurantId = restaurant.id; // Assuming restaurant has an 'id' property
                                    });
                                    Provider.of<DetailRestaurantProvider>(context, listen: false)
                                        .refresh(restaurant.id);
                                  },
                                  child: RestaurantCard(restaurant: restaurant),
                                );
                              },
                              separatorBuilder: (context, index) => const SizedBox(height: 12),
                            ),
                          ],
                        );
                      } else if (state.state == ResultState.noData) {
                        return LottieWidget(
                          assets: Resources.lottieEmpty,
                          description: 'No Result',
                          subtitle: state.message,
                        );
                      } else if (state.state == ResultState.error) {
                        return LottieWidget(
                          assets: Resources.lottieError,
                          description: 'No Result',
                          subtitle: state.message,
                        );
                      } else {
                        return const Center(
                          child: Material(
                            child: Text('Unexpected Error'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const VerticalDivider(thickness: 0.5, width: 1),
        // Right side: Display the restaurant details
        Expanded(
          child: _selectedRestaurantId != null
              ? DetailRestaurantScreen(restaurantId: _selectedRestaurantId!, isBackButtonShow: false)
              : const Center(child: Text('Select a restaurant to see details')),
        ),
      ],
    );
  }
}