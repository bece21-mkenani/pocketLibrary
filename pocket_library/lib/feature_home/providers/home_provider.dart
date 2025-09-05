import 'package:flutter/foundation.dart' hide Category;
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_home/data/mock_book_service.dart';
import 'package:pocket_library/feature_home/models/category_model.dart';

class HomeProvider with ChangeNotifier {
  final MockBookService _bookService;

  HomeProvider(this._bookService) {
    fetchHomeData();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHomeData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categories = await _bookService.getHomeData();
    } catch (e) {
      _errorMessage = AppStrings.failedToLoadbookData;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
