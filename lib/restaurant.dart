import 'dart:convert';

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menu menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menu.fromJson(json["menus"])
    );
  }
}

class Menu {
  Menu({
    required this.foods,
    required this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
    drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
  );
}

class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
  );
}


List<Restaurant> parseRestaurant(String? json) {
  if (json == null) return [];
  final Map<String, dynamic> parsed = jsonDecode(json);
  final List<dynamic> restaurantList = parsed['restaurants'];
  return restaurantList.map((json) => Restaurant.fromJson(json)).toList();
}