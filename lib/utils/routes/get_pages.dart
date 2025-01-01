import 'package:budget_tracker_app/views/screens/home_page.dart';
import 'package:budget_tracker_app/views/screens/splash_screen.dart';
import 'package:get/get.dart';

class GetPages {
  static String splash = '/';
  static String home = '/home';

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: home,
      page: () => HomePage(),
    ),
  ];
}
