import 'dart:convert';

import 'package:http/http.dart' as http;

import '../response/response_detail_restaurant.dart';
import '../response/response_restaurant.dart';
import '../response/response_review.dart';
import '../response/response_search.dart';

class ApiService {
  final String headers = 'application/x-www-form-urlencoded';
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  final String smallImageUrl = 'images/small/';
  final String mediumImageUrl = 'images/medium/';
  final String largeImageUrl = 'images/large/';

  Future<RestaurantListResponse> getListRestaurant() async {
    final response = await http.get(Uri.parse('${baseUrl}list'));
    switch (response.statusCode) {
      case 200:
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      case 400:
        throw Exception('Bad Request: The server could not understand the request.');
      case 404:
        throw Exception('Not Found: The restaurant with the given ID was not found.');
      case 500:
        throw Exception('Internal Server Error: Something went wrong on the server.');
      default:
        throw Exception('Failed to load detail data');
    }
  }

  Future<SearchResponse> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse('${baseUrl}search?q=$query'));
    switch (response.statusCode) {
      case 200:
        return SearchResponse.fromJson(jsonDecode(response.body));
      case 400:
        throw Exception('Bad Request: The server could not understand the request.');
      case 404:
        throw Exception('Not Found: The restaurant with the given ID was not found.');
      case 500:
        throw Exception('Internal Server Error: Something went wrong on the server.');
      default:
        throw Exception('Failed to load detail data');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurantById(String id) async {
    final response = await http.get(Uri.parse('${baseUrl}detail/$id'));
    switch (response.statusCode) {
      case 200:
        var dataJson = jsonDecode(response.body);
        var data = dataJson['restaurant'];
        return DetailRestaurantResponse.fromJson(data);
      case 400:
        throw Exception('Bad Request: The server could not understand the request.');
      case 404:
        throw Exception('Not Found: The restaurant with the given ID was not found.');
      case 500:
        throw Exception('Internal Server Error: Something went wrong on the server.');
      default:
        throw Exception('Failed to load detail data');
    }
  }

  Future<ReviewRestaurantResponse> postReview(id, name, review) async {
    final response = await http.post(Uri.parse('${baseUrl}review'),
      body: jsonEncode({
        'id': id,
        'name': name,
        'review': review,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    switch (response.statusCode) {
      case 200:
        var dataJson = jsonDecode(response.body);
        return ReviewRestaurantResponse.fromJson(dataJson);
      case 400:
        throw Exception('Bad Request: The server could not understand the request.');
      case 404:
        throw Exception('Not Found: The restaurant with the given ID was not found.');
      case 500:
        throw Exception('Internal Server Error: Something went wrong on the server.');
      default:
        throw Exception('Failed to load detail data');
    }
  }

  smallImage(pictureId) {
    String url = "$baseUrl$smallImageUrl$pictureId";
    return url;
  }

  mediumImage(pictureId) {
    String url = "$baseUrl$mediumImageUrl$pictureId";
    return url;
  }

  largeImage(pictureId) {
    String url = "$baseUrl$largeImageUrl$pictureId";
    return url;
  }
}