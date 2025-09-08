import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_widget.dart';
import 'package:pocket_library/constants/app_colors.dart';
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_book/screens/book_detail_screen.dart';
import 'package:pocket_library/feature_search/providers/search_provider.dart';
import 'package:pocket_library/utilities/custom_navigation.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      Provider.of<SearchProvider>(
        context,
        listen: false,
      ).onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<SearchProvider>(context, listen: false).clearSearch();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ImosysTextWidget(
          text: AppStrings.searchBooks,
          size: 24,
          color: Colors.white,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) {
          if (searchProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (searchProvider.errorMessage != null) {
            return Center(
              child: ImosysTextWidget(text: searchProvider.errorMessage!),
            );
          }

          final results = searchProvider.searchResults;

          if (_searchController.text.isNotEmpty && results.isEmpty) {
            return const Center(
              child: ImosysTextWidget(
                text: AppStrings.noResultsFound,
                size: 16,
              ),
            );
          }

          if (results.isEmpty) {
            return const Center(
              child: ImosysTextWidget(
                text: AppStrings.startTypingToSearch,
                size: 16,
                color: Colors.grey,
              ),
            );
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final book = results[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      book.coverImageUrl,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: ImosysTextWidget(text: book.title),
                  subtitle: ImosysTextWidget(text: book.author),
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
