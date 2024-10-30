import 'dart:io';
import 'package:flutter/material.dart';

import '../data/network/api/api_service.dart';
import '../data/network/response/response_detail_restaurant.dart';
import '../enum/state.dart';

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
      notifyListeners();
      final result = await apiService.getDetailRestaurantById(id);
      if (result.toJson().isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restResult = result;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No internet connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }

  // Optionally, create a method to refresh the restaurant details
  void refresh(String newId) {
    id = newId;
    getRestaurantById(id??"");
  }
}