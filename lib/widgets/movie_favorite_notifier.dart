import 'package:flutter/material.dart';

class MovieFavoriteNotifier extends ChangeNotifier {
  Set<String> _favorites = {}; // Set to store favorite movie IDs

  bool isFavorite(String movieId) {
    return _favorites.contains(movieId);
  }

  void toggleFavorite(String movieId) {
    if (_favorites.contains(movieId)) {
      _favorites.remove(movieId);
    } else {
      _favorites.add(movieId);
    }
    notifyListeners();
  }

  List<String> getFavorites() {
    return _favorites.toList();
  }
}
