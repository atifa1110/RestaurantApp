import 'dart:io';
import 'package:flutter/material.dart';
import '../common/state.dart';
import '../data/network/api/api_service.dart';
import '../data/network/response/response_restaurant.dart';

class RestaurantListProvider extends ChangeNotifier {

  late final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    getListRestaurant();
  }

  late RestaurantListResponse _restResult;
  late ResultState _state;
  String _message = '';

  RestaurantListResponse get restResult => _restResult;
  ResultState get state => _state;
  String get message => _message;

  String? _selectedRestaurantId;
  String? get selectedRestaurantId => _selectedRestaurantId;

  void selectRestaurant(String restaurantId) {
    _selectedRestaurantId = restaurantId;
    notifyListeners(); // Notify all listeners that the state has changed
  }

  Future<dynamic> getListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getListRestaurant();
      if (result.restaurants.isEmpty) {
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

  Future<dynamic> refresh() async {
    return await getListRestaurant();
  }
}
