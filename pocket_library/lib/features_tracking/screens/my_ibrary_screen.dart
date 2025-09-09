import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_widget.dart';
import 'package:pocket_library/constants/app_colors.dart';
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_book/screens/book_detail_screen.dart';
import 'package:pocket_library/feature_home/models/book_model.dart';
import 'package:pocket_library/features_tracking/providers/tracking_provider.dart';
import 'package:pocket_library/utilities/custom_navigation.dart';
import 'package:provider/provider.dart';

class MyLibraryScreen extends StatelessWidget {
  const MyLibraryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ImosysTextWidget(
          text: AppStrings.screenTittle,
          size: 24,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TrackingProvider>(
        builder: (context, trackingProvider, child) {
          final startedBooks = trackingProvider.startedBooks;
          final completedBooks = trackingProvider.completedBooks;

          if (startedBooks.isEmpty && completedBooks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  ImosysTextWidget(
                    text: AppStrings.yourLibrary,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  ImosysTextWidget(
                    text: AppStrings.startReading,
                    align: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            children: [
              _buildBookSection(
                context: context,
                title: AppStrings.inProgress,
                books: startedBooks,
                emptyMessage: AppStrings.noBooks,
              ),
              const SizedBox(height: 24),
              _buildBookSection(
                context: context,
                title: AppStrings.complete,
                books: completedBooks,
                emptyMessage: AppStrings.warningMessage,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBookSection({
    required BuildContext context,
    required String title,
    required List<Book> books,
    required String emptyMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ImosysTextWidget(
            text: title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        if (books.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              emptyMessage,
              style: const TextStyle(color: Colors.grey),
            ),
          )
        else
          SizedBox(
            height: 150,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(SlideLeftRoute(page: BookDetailScreen(book: book)));
                  },

                  child: Card(
                    child: SizedBox(
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          book.coverImageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
