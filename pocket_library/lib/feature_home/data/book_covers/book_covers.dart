import 'package:pocket_library/constants/app_images.dart';

class AppImage {
  static const List<String> covers = [
    AppImages.cover1,
    AppImages.cover2,
    AppImages.cover3,
    AppImages.cover1,
    AppImages.cover3,
    AppImages.cover2,
  ];
  static String cover(int index) {
    if (index < 0 || index >= covers.length) {
      return covers[0];
    }
    return covers[index];
  }
}
