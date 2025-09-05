import 'book_model.dart';

class Category {
  final String id;
  final String name;
  final List<Book> books;

  Category({
    required this.id,
    required this.name,
    required this.books,
  });
}
