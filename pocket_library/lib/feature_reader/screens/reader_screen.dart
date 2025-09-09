import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/widgets/imosys_text_widget.dart';
import 'package:pocket_library/constants/app_colors.dart';
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_home/models/book_model.dart';
import 'package:pocket_library/features_tracking/providers/tracking_provider.dart';
import 'package:provider/provider.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;

  const ReaderScreen({super.key, required this.book});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TrackingProvider>(
        context,
        listen: false,
      ).startReading(widget.book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: ImosysTextWidget(
          text: widget.book.title,
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
              text: widget.book.description * 10,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<TrackingProvider>(
          builder: (context, trackingProvider, child) {
            final isCompleted = trackingProvider.isBookCompleted(widget.book);

            return ElevatedButton.icon(
              icon: Icon(
                isCompleted ? Icons.check_circle : Icons.check_circle_outline,
              ),
              label: Text(
                isCompleted ? AppStrings.completed : AppStrings.markascomplete,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isCompleted ? Colors.green : AppColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: isCompleted
                  ? null
                  : () {
                      trackingProvider.completeReading(widget.book);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: ImosysTextWidget(
                              text: AppStrings.bookMarkascomplete,
                              align: TextAlign.center,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.of(context).pop();
                    },
            );
          },
        ),
      ),
    );
  }
}
