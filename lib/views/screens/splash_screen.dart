import 'dart:async';

import 'package:budget_tracker_app/utils/routes/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () {
        Get.offNamed(GetPages.home);
      },
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'asset/images/splash.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
