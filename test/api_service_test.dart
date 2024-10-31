import 'dart:convert';
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_submission_3/data/network/api/api_service.dart';
import 'package:restaurant_submission_3/data/network/response/response_detail_restaurant.dart';
import 'package:restaurant_submission_3/data/network/response/response_restaurant.dart';
import 'package:restaurant_submission_3/data/network/response/response_search.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {

  late ApiService apiService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService();
  });

  group('ApiService', ()
  {
    test(
        'getListRestaurant returns response when status code is 200', () async {
      // Arrange
      final responseJson = jsonEncode({
        "error": false,
        "message": "success",
        "count": 1,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      });

      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(responseJson, 200),
      );

      // Act
      final result = await apiService.getListRestaurant();

      // Assert
      expect(result.error, false);
      expect(result.message, "success");
      expect(result, isA<RestaurantListResponse>());
      expect(result.restaurants[0].name, "Melting Pot");
    });

    test('searchRestaurant returns response when status code is 200', () async {
      // Arrange
      final responseJson = jsonEncode({
        "error": false,
        "founded": 1,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          }
        ]
      });

      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(responseJson, 200),
      );

      // Act
      final result = await apiService.searchRestaurant('melting');

      // Assert
      expect(result, isA<SearchResponse>());
    });

    test('searchRestaurant for status code 200 but search empty', () async {
      // Arrange
      final responseJson = jsonEncode({
        "error": false,
        "founded": 0,
        "restaurants": []
      });
      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(responseJson, 200),
      );

      final result = await apiService.searchRestaurant('melting111');

      // Assert
      expect(result, isA<SearchResponse>());
      expect(result.restaurants.length, 0);
    });

    test(
        'getDetailRestaurantById returns response when status code is 200', () async {
      // Arrange
      final responseJson = jsonEncode({
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description": "Lorem ipsum dolor sit amet,  ...",
          "city": "Medan",
          "address": "Jln. Pandeglang no 19",
          "pictureId": "14",
          "categories": [
            {
              "name": "Italia"
            },
          ],
          "menus": {
            "foods": [
              {
                "name": "Paket rosemary"
              },
            ],
            "drinks": [
              {
                "name": "Sirup"
              }
            ]
          },
          "rating": 4.2,
          "customerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            }
          ]
        }
      });

      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(responseJson, 200),
      );

      // Act
      final result = await apiService.getDetailRestaurantById(
          "rqdv5juczeskfw1e867");

      // Assert
      expect(result, isA<DetailRestaurantResponse>());
      expect(result.name, "Melting Pot");
    });

    test(
        'getDetailRestaurantById throws exception for status code 404', () async {
      // Arrange
      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('Not Found', 404),
      );

      // Call the function and check for an exception
      expect(() async =>
      await apiService.getDetailRestaurantById("rqdv5juczeskf"),
          throwsException);
    });

  });
}