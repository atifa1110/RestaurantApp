import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_submission_3/data/network/response/response_detail_restaurant.dart';
import 'package:restaurant_submission_3/data/network/response/response_restaurant.dart';
import 'package:restaurant_submission_3/data/network/response/response_review.dart';
import 'package:restaurant_submission_3/data/network/response/response_search.dart';

import 'api_mock.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {

  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  group('ApiService', () {
    test('return a restaurant response if the http call completes successfully', () async {
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

      // setup the mock client
      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(responseJson, 200),
      );

      // call the function result
      final result = await ApiServiceMock().getListRestaurant(mockClient);

      // Validate the response fields
      expect(result.error, false);
      expect(result.message, "success");
      expect(result, isA<RestaurantListResponse>());
      expect(result.restaurants[0].name, "Melting Pot");
    });

    test('return a search response if the http call completes successfully', () async {
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
      final result = await ApiServiceMock().searchRestaurant('melting',mockClient);

      // Assert
      expect(result, isA<SearchResponse>());
      expect(result.restaurants.length, 1);
      expect(result.restaurants[0].name, "Melting Pot");
    });

    test('return a search response empty if the http call completes successfully', () async {
      // Arrange
      final responseJson = jsonEncode({
        "error": false,
        "founded": 0,
        "restaurants": []
      });
      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(responseJson, 200),
      );

      final result = await ApiServiceMock().searchRestaurant('melting111',mockClient);

      // Assert
      expect(result, isA<SearchResponse>());
      expect(result.restaurants.length, 0);
    });

    test('return a detail response if the http call completes successfully', () async {
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
      final result = await ApiServiceMock().getDetailRestaurantById("rqdv5juczeskfw1e867",mockClient);

      // Assert
      expect(result, isA<DetailRestaurantResponse>());
      expect(result.name, "Melting Pot");
    });

    test('return a detail throws exception if the http call status code 404', () async {
      // Arrange
      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('Not Found', 404),
      );

      // Call the function and check for an exception
      expect(() async => await ApiServiceMock().getDetailRestaurantById("rqdv5juczeskf",mockClient),
          throwsException);
    });

    test('return a review response if the http call completes successfully', () async {
      // Arrange
      final responseJson = jsonEncode({
        "error": false,
        "message": "success",
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          },
          {
            "name": "test",
            "review": "makanannya lezat",
            "date": "29 Oktober 2020"
          }
        ]
      });

      when(mockClient.post(any,
        body: jsonEncode({
          'id': "rqdv5juczeskfw1e867",
          'name': "test",
          'review': "makanannya lezat",
        }),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response(responseJson, 200));

      // Act
      final result = await ApiServiceMock().postReview("rqdv5juczeskfw1e867", "test",
          "makanannya lezat", mockClient
      );

      // Assert
      expect(result, isA<ReviewRestaurantResponse>());
      expect(result.customerReviews[1].name, "test");
    });

  });
}