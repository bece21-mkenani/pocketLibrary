import 'package:pocket_library/feature_home/data/book_covers/book_covers.dart';
import 'package:pocket_library/feature_home/models/book_model.dart';
import 'package:pocket_library/feature_home/models/category_model.dart';

class MockBookService {
  Future<List<Category>> getHomeData() async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockCategories;
  }

  static final List<Category> _mockCategories = [
    Category(
      id: 'cat1',
      name: 'Featured Fiction',
      books: List.generate(
        6,
        (index) => Book(
          id: 'fic$index',
          title: 'The Midnight Library $index',
          author: 'Mphatso Kenani',
          coverImageUrl: AppImage.cover(index),
          genre: 'Fiction',
          description:
          "A gripping tale that blends imagination with raw emotion this novel explores the journey of characters caught between love, loss, and destiny. With vivid storytelling and unforgettable scenes, it keeps readers turning pages while leaving space for reflection on life’s deeper truths.",
        ),
      ),
    ),
    Category(
      id: 'cat2',
      name: 'Popular Science',
      books: List.generate(
        5,
        (index) => Book(
          id: 'sci$index',
          title: 'Sapiens: A Brief History $index',
          author: 'Mk Kenani',
          coverImageUrl: AppImage.cover(index + 1),
          genre: 'Science',
          description:
          "This book breaks down complex scientific ideas into clear, engaging explanations for everyone. From the mysteries of the universe to the science behind everyday life, it makes learning exciting and easy to follow, sparking curiosity and wonder in every chapter.",
        ),
      ),
    ),
    Category(
      id: 'cat3',
      name: 'History Revisited',
      books: List.generate(
        7,
        (index) => Book(
          id: 'his$index',
          title: 'The Guns of August $index',
          author: 'Vega',
          coverImageUrl: AppImage.cover(index + 2),
          genre: 'History',
          description:
          "A fresh look at history that brings forgotten events and hidden perspectives to life. By weaving together facts and compelling storytelling, this book makes the past feel relevant and alive, showing how yesterday’s choices continue to shape the world today.",
        ),
      ),
    ),
  ];

  Future<List<Book>> searchBooks(String query) async {
   
    await Future.delayed(const Duration(milliseconds: 500));

    if (query.isEmpty) {
      return [];
    }

    final lowerCaseQuery = query.toLowerCase();
    final List<Book> allBooks = [];


    for (var category in _mockCategories) {
      allBooks.addAll(category.books);
    }
  
    final results = allBooks.where((book) {
      final titleMatches = book.title.toLowerCase().contains(lowerCaseQuery);
      final authorMatches = book.author.toLowerCase().contains(lowerCaseQuery);
      return titleMatches || authorMatches;
    }).toList();

    return results;
  }
}

