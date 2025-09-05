import 'package:flutter/material.dart';
import 'package:imosys_flutter_package/imosys_flutter_package.dart';
import 'package:pocket_library/constants/strings.dart';
import 'package:pocket_library/feature_auth/screens/login_screen.dart';
import 'package:pocket_library/feature_favorite/providers/favorite_provider.dart';
import 'package:pocket_library/feature_home/data/mock_book_service.dart';
import 'package:pocket_library/feature_home/providers/home_provider.dart';
import 'package:pocket_library/feature_search/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'constants/app_colors.dart';
import 'feature_auth/data/auth_repository.dart';
import 'feature_auth/providers/auth_provider.dart';

void main() {
  final authRepository = AuthRepository();
  final mockBookService = MockBookService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository)),
        ChangeNotifierProvider(create: (_) => HomeProvider(mockBookService)),
        ChangeNotifierProvider(create: (_) => SearchProvider(mockBookService)),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: ImosysAppWrapper(
        config: ImosysConfig(
          defaultFontSize: 16.0,
          defaultFontColor: AppColors.textDark,
          primaryColor: AppColors.primary,
          defaultHorizontalPadding: 16.0,
          defaultVerticalPadding: 14.0,
          defaultHorizontalMargin: 16.0,
          defaultVerticalMargin: 16.0,
          defaultContainerRadius: 16.0,
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
