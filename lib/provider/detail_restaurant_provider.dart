import 'dart:io';
import 'package:flutter/material.dart';

import '../common/state.dart';
import '../data/network/api/api_service.dart';
import '../data/network/response/response_detail_restaurant.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late String id;

  DetailRestaurantProvider({required this.apiService});

  late DetailRestaurantResponse _restResult;
  late ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;
  DetailRestaurantResponse get result => _restResult;
  ResultState get state => _state;

  Future<dynamic> getRestaurantById(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners(); // Notify listeners of the loading state

      final result = await apiService.getDetailRestaurantById(id);
      if (result.toJson().isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty data';
      } else {
        _restResult = result;
        _state = ResultState.hasData; // Update state after fetching data
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      _message = 'No internet connection';
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error -> $e';
    } finally {
      notifyListeners();
    }// Notify listeners after the state update
  }

  // Optionally, create a method to refresh the restaurant details
  void refresh(String newId) {
    id = newId;
    getRestaurantById(id??"");
  }
}