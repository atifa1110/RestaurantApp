import 'package:hive/hive.dart';

class DatabaseHelper {
  final Box favoritesBox = Hive.box('favoritesBox');

  // Get all favorite items
  List<dynamic> getFavorites() {
    return favoritesBox.values.toList();
  }

  // Add favorite item by id
  Future<void> addFavorite(String id) async {
    await favoritesBox.put(id, id);
  }

  // Remove favorite item by id
  Future<void> removeFavorite(String id) async {
    await favoritesBox.delete(id);
  }

  // Check if item is a favorite by id
  bool isFavorite(String id) {
    return favoritesBox.containsKey(id);
  }
}
