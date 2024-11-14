import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_submission_3/common/state.dart';
import 'package:restaurant_submission_3/data/network/api/api_service.dart';
import 'package:restaurant_submission_3/data/network/model/restaurant.dart';
import 'package:restaurant_submission_3/data/network/response/response_restaurant.dart';
import 'package:restaurant_submission_3/provider/restaurant_list_provider.dart';

import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {

  late MockApiService mockApiService;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantListProvider(apiService: mockApiService);
  });

  group('RestaurantListProvider Tests', () {
    test('should set state to noData when API returns empty data', () async {
      // Arrange
      final mockResponse = RestaurantListResponse(
        error: false,
        message: 'success',
        count: 0,
        restaurants: [],
      );

      when(mockApiService.getListRestaurant()).thenAnswer((_) async => Future.value(mockResponse));

      // Act
      await provider.getListRestaurant();

      // Assert
      // Verifies mock call
      expect(provider.state, ResultState.noData);
      expect(provider.message, 'Empty data');
    });

    test('should return data and set state to hasData when API call is successful', () async {
      // Arrange
      final mockResponse = RestaurantListResponse(
        error: false,
        message: "success",
        count: 1,
        restaurants: [
          Restaurant(
              id: "rqdv5juczeskfw1e867",
              name: "Melting Pot",
              description: "Lorem ipsum dolor sit amet.",
              pictureId: "14",
              city: "Medan",
              rating: 4.2
          )
        ],
      );

      // Mock the API call to return a successful response
      when(mockApiService.getListRestaurant()).thenAnswer((_) async => Future.value(mockResponse));

      // When
      final restaurants = await provider.getListRestaurant();

      // Assert
      expect(provider.state, ResultState.hasData);
      expect(restaurants, isA<RestaurantListResponse>()); // Use correct type checks
    });

    test('should set state to error with no internet connection message on SocketException', () async {
      // Arrange
      when(mockApiService.getListRestaurant()).thenThrow(const SocketException('No Internet'));

      // Act
      await provider.getListRestaurant();

      // Assert
      expect(provider.state, ResultState.error);
      expect(provider.message, 'No internet connection');
    });

    test('should set state to error with exception message on other errors', () async {
      // Arrange
      when(mockApiService.getListRestaurant()).thenThrow(Exception('Internal Server Error: Something went wrong on the server.'));

      // Act
      await provider.getListRestaurant();

      // Assert
      expect(provider.state, ResultState.error);
      expect(provider.message, contains('Error -> Exception: Internal Server Error: Something went wrong on the server.'));
    });
  });
}