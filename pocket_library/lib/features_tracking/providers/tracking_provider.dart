import 'package:flutter/foundation.dart';
import 'package:pocket_library/feature_home/models/book_model.dart';

class TrackingProvider with ChangeNotifier {
  final List<Book> _startedBooks = [];
  final List<Book> _completedBooks = [];
  List<Book> get startedBooks => _startedBooks;
  List<Book> get completedBooks => _completedBooks;
  void startReading(Book book) {
    if (!_startedBooks.any((b) => b.id == book.id) &&
        !_completedBooks.any((b) => b.id == book.id)) {
      _startedBooks.add(book);
      notifyListeners();
    }
  }

  void completeReading(Book book) {
    _startedBooks.removeWhere((b) => b.id == book.id);

    if (!_completedBooks.any((b) => b.id == book.id)) {
      _completedBooks.add(book);
      notifyListeners();
    }
  }
  bool isBookStarted(Book book) {
    return _startedBooks.any((b) => b.id == book.id);
  }

  bool isBookCompleted(Book book) {
    return _completedBooks.any((b) => b.id == book.id);
  }
}
