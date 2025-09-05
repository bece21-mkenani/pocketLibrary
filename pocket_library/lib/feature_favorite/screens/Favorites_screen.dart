import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_widget.dart';
import 'package:pocket_library/constants/app_colors.dart';
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_book/screens/book_detail_screen.dart';
import 'package:pocket_library/feature_favorite/providers/favorite_provider.dart';
import 'package:pocket_library/utilities/custom_navigation.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: ImosysTextWidget(
          text: AppStrings.myfavorite,
          size: 24,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favoriteBooks = favoritesProvider.favoriteBooks;

          if (favoriteBooks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  ImosysTextWidget(
                    text: AppStrings.notYetMyfavorite,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  ImosysTextWidget(
                    text: AppStrings.addToFavoritesToSeeThem,
                    style: Theme.of(context).textTheme.bodyLarge,
                    align: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              final book = favoriteBooks[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      book.coverImageUrl,
                      width: 50,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: ImosysTextWidget(
                    text: book.title,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: ImosysTextWidget(text: book.author),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(SlideLeftRoute(page: BookDetailScreen(book: book)));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
