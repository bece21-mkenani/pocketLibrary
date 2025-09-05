import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/widgets/imosys_button.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_widget.dart';
import 'package:pocket_library/constants/app_colors.dart';
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_favorite/screens/Favorites_screen.dart';
import 'package:pocket_library/feature_home/models/category_model.dart';
import 'package:pocket_library/feature_home/providers/home_provider.dart';
import 'package:pocket_library/feature_home/widgets/book_card_widget.dart';
import 'package:pocket_library/utilities/custom_navigation.dart';
import 'package:pocket_library/feature_search/screens/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).fetchHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: ImosysTextWidget(
          text: AppStrings.bookStore,
          size: 24,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(
                context,
              ).push(SlideLeftRoute(page: const SearchScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality
            },
          ),
        ],
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImosysTextWidget(text: provider.errorMessage!),
                  const SizedBox(height: 16),
                  ImosysButton(
                    text: AppStrings.retry,
                    onTap: () => provider.fetchHomeData(),
                  ),
                ],
              ),
            );
          }

          return _buildCategoryList(provider.categories);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(SlideLeftRoute(page: const FavoritesScreen()));
        },
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.favorite, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryList(List<Category> categories) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryRow(context, category);
      },
    );
  }

  Widget _buildCategoryRow(BuildContext context, Category category) {
    final booksToShow = category.books.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ImosysTextWidget(
            text: category.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: booksToShow.length,
            itemBuilder: (context, index) {
              final book = booksToShow[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: BookCard(book: book),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
