import 'dart:convert';

import '../model/customer_review.dart';

ReviewRestaurantResponse restaurantReviewFromJson(String str) => ReviewRestaurantResponse.fromJson(json.decode(str));
String restaurantReviewToJson(ReviewRestaurantResponse data) => json.encode(data.toJson());

class ReviewRestaurantResponse {
  ReviewRestaurantResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerReview> customerReviews;

  factory ReviewRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      ReviewRestaurantResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "customerReviews":
    List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}
