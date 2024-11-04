import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/state.dart';
import '../component/bottom_sheet_holder.dart';
import '../component/input_filed_area.dart';
import '../component/text_filed_area.dart';
import '../provider/post_review_provider.dart';
import '../theme/app_size.dart';
import '../component/review_card.dart';
import '../provider/detail_restaurant_provider.dart';
import '../theme/app_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as customBottom;

class ReviewRestaurantScreen extends StatefulWidget {
  static const routeName = '/reviewCustomer';

  final String? restaurantId;

  const ReviewRestaurantScreen({super.key, this.restaurantId});

  @override
  State<ReviewRestaurantScreen> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewRestaurantScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        await context
            .read<DetailRestaurantProvider>()
            .getRestaurantById(widget.restaurantId??"");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colorScheme.onSecondary,
        appBar: AppBar(
          backgroundColor: colorScheme.onSecondary,
          centerTitle: true,
          title: Text(
            'Reviews',
            style: AppThemes.headline3.copyWith(
                color: colorScheme.onSecondaryContainer
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _showMyModalBottomSheet(context, widget.restaurantId??"");
              },
            ),
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
                print("Restaurant Review: ${restaurant.customerReviews.length}");
                return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Sizes.p16),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap.h8,
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 0),
                                itemCount: restaurant.customerReviews.length,
                                itemBuilder: (context, index) {
                                  final review = restaurant.customerReviews[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: Sizes.p16),
                                    child: ReviewCard(review: review),
                                  );
                                }
                            ),
                          ]
                      ),
                    )
                );
              } else if (state.state == ResultState.noData) {
                return Center(
                  child: Material(
                    child: Text(state.message),
                  ),
                );
              } else if (state.state == ResultState.error) {
                return Center(
                  child: Material(
                    child: Text(state.message),
                  ),
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

  void _showMyModalBottomSheet(BuildContext context, String restaurantId) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController reviewController = TextEditingController();

    customBottom.showMaterialModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final colorScheme = Theme.of(context).colorScheme;
        final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
        return Container(
          width: double.infinity,
          color: colorScheme.onSecondary,
          //height: 500,
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, bottomPadding + 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetHolder(),
              Gap.h20,
              Text(
                'Add Review',
                style: AppThemes.headline3.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.start,
              ),
              Gap.h20,
              InputTextField(
                hintText: 'Input your name here...',
                labelText: 'Name',
                nameController: nameController,
                onChanged: (value) {},
              ),
              Gap.h20,
              TextFieldArea(
                hintText: 'Input your Reviews here...',
                labelText: 'Review',
                reviewController: reviewController,
                onChanged: (value) {},
              ),
              Gap.h40,
              SizedBox(
                width: double.infinity, // Set the width
                height: 48, // Set the height
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemes.green, // Button background color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Makes the button square
                    ),
                  ),
                  onPressed: () async {
                    context.read<PostReviewProvider>().postReview(
                        restaurantId,
                        nameController.text,
                        reviewController.text
                    ).whenComplete(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
