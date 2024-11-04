import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_submission_3/theme/app_size.dart';
import '../common/state.dart';
import '../component/favorite_card.dart';
import '../component/lottie_widget.dart';
import '../component/restaurant_app_bar.dart';
import '../data/network/response/response_detail_restaurant.dart';
import '../provider/database_provider.dart';
import '../provider/detail_restaurant_provider.dart';
import '../theme/resource.dart';

class FavoriteRestaurantScreen extends StatefulWidget {
  const FavoriteRestaurantScreen({super.key});

  @override
  State<FavoriteRestaurantScreen> createState() => _FavoriteRestaurantPageState();
}

class _FavoriteRestaurantPageState extends State<FavoriteRestaurantScreen> {

  List<DetailRestaurantResponse> favoriteRestaurants = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      // Ensure the widget is still mounted before proceeding
      if (mounted) {
        await _loadFavoriteRestaurants();
      }
    });
  }

  Future<void> _loadFavoriteRestaurants() async {
    final favoriteIds = context.read<DatabaseProvider>().favorite;

    // Fetch all favorite restaurants
    final fetchedRestaurants = await _fetchFavoriteRestaurants(context, favoriteIds);
    setState(() {
      favoriteRestaurants = fetchedRestaurants;
    });
  }

  Future<List<DetailRestaurantResponse>> _fetchFavoriteRestaurants(BuildContext context, List<String> favoriteIds) async {
    List<DetailRestaurantResponse> favoriteRestaurants = [];

    for (var id in favoriteIds) {
      await context.read<DetailRestaurantProvider>().getRestaurantById(id);
      final provider = context.read<DetailRestaurantProvider>();

      if (provider.state == ResultState.hasData) {
        favoriteRestaurants.add(provider.result);
      } else {
        print('Failed to fetch restaurant with ID: $id, message: ${provider.message}');
      }
    }

    return favoriteRestaurants;
  }

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
        body:
        ListView(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p24,vertical: Sizes.p8),
            children: [
              Consumer<DatabaseProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state.state == ResultState.hasData) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: favoriteRestaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = favoriteRestaurants[index];
                          return FavoriteRestaurantCard(restaurant: restaurant);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                      );
                    } else if (state.state == ResultState.noData) {
                      return const LottieWidget(
                        assets: Resources.lottieFavorite,
                        description: 'No Favorite yet',
                        subtitle: "please add you're interest restaurant \nby click love button",
                      );
                    } else if (state.state == ResultState.error) {
                      return LottieWidget(
                        assets: Resources.lottieError,
                        description: "There is something wrong",
                        subtitle: state.message,
                      );
                    } else {
                      return const Center(
                        child: Material(
                          child: Text('Unexpected Error'),
                        ),
                      );
                    }
                  }
              ),
            ]
        ),

      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const RestaurantAppBar(),
            backgroundColor: Colors.white,
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p24,vertical: Sizes.p8),
              children: [
                Consumer<DatabaseProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.loading) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }else if (state.state == ResultState.hasData){
                        return FutureBuilder<List<DetailRestaurantResponse>>(
                          future: _fetchFavoriteRestaurants(context,state.favorite), // Call the method here
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return LottieWidget(
                                assets: Resources.lottieError,
                                description: "There is something wrong",
                                subtitle: snapshot.error.toString(),
                              );
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const LottieWidget(
                                assets: Resources.lottieFavorite,
                                description: 'No Favorite yet',
                                subtitle: "please add your favorite restaurant by clicking the love button",
                              );
                            } else {
                              var favoriteRestaurants = snapshot.data?? List.empty();
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Number of columns in the grid
                                  crossAxisSpacing: 10, // Spacing between columns
                                  mainAxisSpacing: 10, // Spacing between rows
                                  childAspectRatio: 4 / 3,
                                ),
                                itemCount: state.favorite.length,
                                itemBuilder: (context, index) {
                                  var restaurant = favoriteRestaurants[index];
                                  return FavoriteRestaurantCard(restaurant: restaurant);
                                },
                              );
                            }
                          },
                        );
                      }else if (state.state == ResultState.noData){
                        return const LottieWidget(
                          assets: Resources.lottieFavorite,
                          description: 'No Favorite yet',
                          subtitle: "please add you're interest restaurant \nby click love button",
                        );
                      }else if (state.state == ResultState.error) {
                        return LottieWidget(
                          assets: Resources.lottieError,
                          description: "There is something wrong",
                          subtitle: state.message,
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
              ],
            )
        )
    );
  }

}
