import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_widget.dart';
import 'package:pocket_library/constants/app_colors.dart';
import 'package:pocket_library/feature_home/models/book_model.dart';

class ReaderScreen extends StatelessWidget {
  final Book book;

  const ReaderScreen({super.key, required this.book});

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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImosysTextWidget(
              text: 'Chapter 1',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ImosysTextWidget(
              text: book.description * 10,
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
    );
  }
}
