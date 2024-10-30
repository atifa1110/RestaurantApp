import 'dart:io';
import 'package:flutter/material.dart';
import '../data/network/api/api_service.dart';
import '../data/network/response/response_search.dart';
import '../enum/state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}){
    _restResult = SearchResponse(restaurants: [], error: true, founded: 0);
    _state = ResultState.noData;
    _message = "No Restaurant";
    notifyListeners();
  }

  late SearchResponse _restResult;
  late ResultState _state;
  String _message = '';

  SearchResponse get restResult => _restResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> getSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.searchRestaurant(query);
      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'No Result Found';
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

  void clearSearchResults() {
    _restResult = SearchResponse(restaurants: [], error: true, founded: 0);
    _state = ResultState.noData;
    _message = 'No Result';
    notifyListeners();
  }
}