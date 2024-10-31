import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../common/state.dart';
import '../data/network/api/api_service.dart';
import '../data/network/response/response_review.dart';

class PostReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  PostReviewProvider({required this.apiService});

  late ReviewRestaurantResponse _restResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  ReviewRestaurantResponse get restResult => _restResult;
  ResultState get state => _state;

  Future<dynamic> postReview(String id, String name, String review) async {
    if (name.isEmpty || review.isEmpty) {
      _state = ResultState.noData;
      _message = 'Please enter name and review correctly!';
      notifyListeners();
      return;
    }
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.postReview(id, name, review);
      if (result.customerReviews.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Review is Empty';
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
}