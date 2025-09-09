import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_widget.dart';
import 'package:pocket_library/constants/app_colors.dart';
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_favorite/providers/favorite_provider.dart';
import 'package:pocket_library/feature_home/models/book_model.dart';
import 'package:pocket_library/feature_reader/screens/reader_screen.dart';
import 'package:pocket_library/utilities/custom_navigation.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: ImosysTextWidget(
          text: book.title,
          size: 24,
          color: Colors.white,
        ),

        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              child: Image.asset(
                book.coverImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.book, size: 100, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImosysTextWidget(
                    text: book.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ImosysTextWidget(
                    text: 'by ${book.author}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  ImosysTextWidget(
                    text: AppStrings.aboutThisbook,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 16),
                  ImosysTextWidget(
                    text: book.description,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      height: 1.6,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _buildActionButtons(context),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final isBookFavorite = favoritesProvider.isFavorite(book);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(
                      isBookFavorite ? Icons.favorite : Icons.favorite_border,
                    ),

                    label: ImosysTextWidget(
                      text: isBookFavorite
                          ? AppStrings.removeToFavorites
                          : AppStrings.addToFavorites,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isBookFavorite
                          ? Colors.red[50]
                          : Colors.green[400],
                      foregroundColor: isBookFavorite
                          ? Colors.redAccent
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      favoritesProvider.toggleFavorite(book);
                    },
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.menu_book),
                    label: ImosysTextWidget(text: AppStrings.readNow),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(SlideLeftRoute(page:  ReaderScreen(book:book)));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
