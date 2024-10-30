import 'dart:convert';
import 'package:restaurant_submission_2/data/network/model/restaurant.dart';

RestaurantListResponse restaurantResponseFromJson(String str) => RestaurantListResponse.fromJson(json.decode(str));
String restaurantResponseToJson(RestaurantListResponse data) => json.encode(data.toJson());

class RestaurantListResponse {
  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantListResponse(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
