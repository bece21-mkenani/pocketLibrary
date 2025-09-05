import 'package:flutter/foundation.dart';
import 'package:pocket_library/feature_home/models/book_model.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Book> _favoriteBooks = [];
  List<Book> get favoriteBooks => _favoriteBooks;
  bool isFavorite(Book book) {
    return _favoriteBooks.any((b) => b.id == book.id);
  }

  void addFavorite(Book book) {
    if (!isFavorite(book)) {
      _favoriteBooks.add(book);
      notifyListeners();
    }
  }

  void removeFavorite(Book book) {
    _favoriteBooks.removeWhere((b) => b.id == book.id);
    notifyListeners();
  }

  void toggleFavorite(Book book) {
    if (isFavorite(book)) {
      removeFavorite(book);
    } else {
      addFavorite(book);
    }
  }
}
