import 'package:flutter/material.dart';
import 'package:restaurant_submission_3/theme/text_style.dart';
import '../data/network/model/customer_review.dart';
import '../theme/app_size.dart';
import '../theme/app_theme.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });

  final CustomerReview review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.p20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.p20),
        color: AppThemes.lightGrey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.name,
                style: AppThemes.text2,
              ),
              Text(
                review.date,
                style: AppThemes.text2,
              ),
            ],
          ),
          Gap.h8,
          Text(
            review.review,
            style: AppThemes.text1.semiBold,
          )
        ],
      ),
    );
  }
}