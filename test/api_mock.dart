import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_submission_3/data/network/response/response_detail_restaurant.dart';
import 'package:restaurant_submission_3/data/network/response/response_restaurant.dart';
import 'package:restaurant_submission_3/data/network/response/response_review.dart';
import 'package:restaurant_submission_3/data/network/response/response_search.dart';

class ApiServiceMock {
  final String headers = 'application/x-www-form-urlencoded';
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantListResponse> getListRestaurant(http.Client client) async {
    final response = await client.get(Uri.parse('${baseUrl}list'));
    switch (response.statusCode) {
      case 200:
        return RestaurantListResponse.fromJson(jsonDecode(response.body));
      case 400:
        throw Exception(
            'Bad Request: The server could not understand the request.');
      case 404:
        throw Exception('Not Found: The restaurant is empty');
      case 500:
        throw Exception(
            'Internal Server Error: Something went wrong on the server.');
      default:
        throw Exception('Failed to load detail data');
    }
  }

  Future<SearchResponse> searchRestaurant(String query,http.Client client) async {
    final response = await client.get(Uri.parse('${baseUrl}search?q=$query'));
    switch (response.statusCode) {
      case 200:
        return SearchResponse.fromJson(jsonDecode(response.body));
      case 400:
        throw Exception(
            'Bad Request: The server could not understand the request.');
      case 404:
        throw Exception(
            'Not Found: The restaurant with the given ID was not found.');
      case 500:
        throw Exception(
            'Internal Server Error: Something went wrong on the server.');
      default:
        throw Exception('Failed to load detail data');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurantById(String id, http.Client client) async {
    final response = await client.get(Uri.parse('${baseUrl}detail/$id'));
    switch (response.statusCode) {
      case 200:
        var dataJson = jsonDecode(response.body);
        var data = dataJson['restaurant'];
        return DetailRestaurantResponse.fromJson(data);
      case 400:
        throw Exception(
            'Bad Request: The server could not understand the request.');
      case 404:
        throw Exception(
            'Not Found: The restaurant with the given ID was not found.');
      case 500:
        throw Exception(
            'Internal Server Error: Something went wrong on the server.');
      default:
        throw Exception('Failed to load detail data');
    }
  }

  Future<ReviewRestaurantResponse> postReview(id, name, review, http.Client client) async {
    final response = await client.post(Uri.parse('${baseUrl}review'),
      body: jsonEncode({
        'id': id,
        'name': name,
        'review': review,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    switch (response.statusCode) {
      case 200:
        return ReviewRestaurantResponse.fromJson(jsonDecode(response.body));
      case 400:
        throw Exception(
            'Bad Request: The server could not understand the request.');
      case 404:
        throw Exception(
            'Not Found: The restaurant with the given ID was not found.');
      case 500:
        throw Exception(
            'Internal Server Error: Something went wrong on the server.');
      default:
        throw Exception('Failed to load detail data');
    }
  }
}
