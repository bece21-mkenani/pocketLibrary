import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_widget.dart';
import 'package:pocket_library/feature_book/screens/book_detail_screen.dart';
import 'package:pocket_library/feature_home/models/book_model.dart';
import 'package:pocket_library/utilities/custom_navigation.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Ink.image(
                image: AssetImage(book.coverImageUrl),
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(SlideLeftRoute(page: BookDetailScreen(book: book)));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImosysTextWidget(
                    text: book.title,
                    maxLines: 1,
                    size: 14,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4),
                  ImosysTextWidget(
                    text: book.author,
                    maxLines: 1,
                    size: 14,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
