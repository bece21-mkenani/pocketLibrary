import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pocket_library/feature_home/data/mock_book_service.dart';
import 'package:pocket_library/feature_home/models/book_model.dart';

class SearchProvider with ChangeNotifier {
  final MockBookService _bookService;

  SearchProvider(this._bookService);

  List<Book> _searchResults = [];
  bool _isLoading = false;
  String? _errorMessage;
  Timer? _debounce;

  List<Book> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query.trim());
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await _bookService.searchBooks(query);
    } catch (e) {
      _errorMessage = 'Failed to perform search. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
