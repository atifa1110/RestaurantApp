import 'package:flutter/material.dart';
import '../common/state.dart';
import '../data/local/database_helper.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  ResultState? _state;
  String _message = '';
  List<String> _favorite = [];

  ResultState? get state => _state;
  String get message => _message;
  List<String> get favorite => _favorite;

  void _getFavorite() async {
    try {
      _state = ResultState.loading;
      _favorite = databaseHelper.getFavorites().cast<String>().toList();
      if (_favorite.isNotEmpty) {
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
        _message = 'Data is Empty';
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
    }
    notifyListeners();
  }

  void addFavorite(String id) async {
    try {
      await databaseHelper.addFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  // Check if item is a favorite
  Future<bool> isFavorite(String id) async {
    return Future.value(databaseHelper.isFavorite(id)); // Wrap the bool in Future
  }
}
