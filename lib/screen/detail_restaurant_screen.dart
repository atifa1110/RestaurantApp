import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../common/state.dart';
import '../component/snackbar.dart';
import '../provider/database_provider.dart';
import '../theme/app_size.dart';
import '../component/lottie_widget.dart';
import '../component/menus_card.dart';
import '../theme/app_theme.dart';
import '../theme/resource.dart';
import '../component/restaurant_information.dart';
import '../data/network/api/api_service.dart';
import '../data/network/response/response_detail_restaurant.dart';
import '../provider/detail_restaurant_provider.dart';
import '../routing/app_routes.dart';
import '../routing/extras.dart';
import '../routing/key.dart';

class DetailRestaurantScreen extends StatefulWidget {
  static const routeName = '/detailRestaurant';

  final String? restaurantId;
  final bool isBackButtonShow;

  const DetailRestaurantScreen({super.key, this.restaurantId, required this.isBackButtonShow});

  @override
  State<DetailRestaurantScreen> createState() => _RestaurantDetailPageState();

}

class _RestaurantDetailPageState extends State<DetailRestaurantScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        await context.read<DetailRestaurantProvider>()
            .getRestaurantById(widget.restaurantId??"");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: widget.isBackButtonShow ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ) : null,
              actions: [
                Consumer<DatabaseProvider>(
                  builder: (context, provider, child) => FutureBuilder<bool>(
                    future: provider.isFavorite(widget.restaurantId ?? ""),
                    builder: (context, snapshot) {
                      bool isFavorite = snapshot.data ?? false;
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          if (isFavorite) {
                            provider.removeFavorite(widget.restaurantId ?? "");
                            Snackbar.show(context, 'Item has been removed from favorites');
                          } else {
                            provider.addFavorite(widget.restaurantId ?? "");
                            Snackbar.show(context, 'Item has been added to favorites');
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            body: Consumer<DetailRestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.state == ResultState.hasData) {
                    var restaurant = state.result;
                    return SingleChildScrollView(
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
                                            bottomRight: Radius.circular(Sizes.p32),
                                          ),
                                          child: AspectRatio(
                                              aspectRatio: 4 / 3,
                                              child: Image.network(
                                                '${ApiService().mediumImage(restaurant.pictureId)}',
                                                fit: BoxFit.cover,
                                              )
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                              Gap.h12,
                              Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RestaurantInformation(restaurant: restaurant),
                                        Gap.h16,
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
                                        Gap.h16,
                                        Text(
                                          'Foods',
                                          style: AppThemes.headline3,
                                        ),
                                        Gap.h8,
                                        _getFoodList(restaurant),
                                        Gap.h20,
                                        Text(
                                          'Drinks',
                                          style: AppThemes.headline3,
                                        ),
                                        Gap.h8,
                                        _getDrinkList(restaurant),
                                        Gap.h20,
                                        GestureDetector(
                                          onTap: () {
                                            context.pushNamed(
                                              Routes.reviewCustomer.name,
                                              extra: Extras(
                                                extras: {
                                                  Keys.restaurantId: restaurant.id,
                                                },
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xFFEAEAEA)),  // Border color and width
                                              borderRadius: BorderRadius.circular(16.0),           // Rounded corners
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Reviews',
                                                  style: AppThemes.headline3,
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward,
                                                  color: AppThemes.green,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Gap.h12,
                                      ]
                                  )
                              ),
                            ]
                        )
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
                }
            )
    );
  }

  Widget _getFoodList(DetailRestaurantResponse restaurant) {
    return SizedBox(
      height: 150, // Set the desired height for the card list
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: restaurant.menus.foods.length, // Change to your data length
        itemBuilder: (context, index) {
          final food = restaurant.menus.foods[index]; // Accessing data
          return MenusCard(names: food.name);
        }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width:Sizes.p12)  ,
      ),
    );
  }

  Widget _getDrinkList(DetailRestaurantResponse restaurant) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: restaurant.menus.drinks.length,
        itemBuilder: (context, index) {
          final drink = restaurant.menus.drinks[index];
          return MenusCard(names: drink.name);
        },separatorBuilder: (BuildContext context, int index) => const SizedBox(width:Sizes.p12)  ,
      ),
    );
  }

}