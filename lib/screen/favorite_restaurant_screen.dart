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

  @override
  void initState() {
    super.initState();
    // Trigger loading after the first build phase
    Future.microtask(() {
      final favoriteProvider = context.read<DatabaseProvider>();
      final detailProvider = context.read<DetailRestaurantProvider>();
      final favoriteIds = context.read<DatabaseProvider>().favorite;
      favoriteProvider.loadFavoriteRestaurants(detailProvider, favoriteIds);
    });
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
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p24,vertical: Sizes.p8),
            children: [ Consumer<DatabaseProvider>(
                builder: (context, favoriteProvider, _) {
                  if (favoriteProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (favoriteProvider.favoriteRestaurants.isNotEmpty) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: favoriteProvider.favoriteRestaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = favoriteProvider.favoriteRestaurants[index];
                        return FavoriteRestaurantCard(restaurant: restaurant);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                    );
                  } else {
                    return const LottieWidget(
                      assets: Resources.lottieFavorite,
                      description: 'No Favorite yet',
                      subtitle: 'Add restaurants to your favorites by clicking the love button.',
                    );
                  }
                },
              )
            ]
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
        child: Scaffold(
          appBar: const RestaurantAppBar(),
          backgroundColor: colorScheme.onSecondary,
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p24,vertical: Sizes.p8),
            children: [Consumer<DatabaseProvider>(
                builder: (context, favoriteProvider,_) {
                  if (favoriteProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (favoriteProvider.favoriteRestaurants.isNotEmpty) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 10, // Spacing between columns
                        mainAxisSpacing: 10, // Spacing between rows
                        childAspectRatio: 4 / 3,
                      ),
                      itemCount: favoriteProvider.favoriteRestaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = favoriteProvider.favoriteRestaurants[index];
                        return FavoriteRestaurantCard(restaurant: restaurant);
                      },
                    );
                  } else {
                    return const LottieWidget(
                      assets: Resources.lottieFavorite,
                      description: 'No Favorite yet',
                      subtitle: 'Add restaurants to your favorites by clicking the love button.',
                    );
                  }
                },
              )
            ],
          ),
        )
    );
  }
}
