import 'package:flutter/material.dart';

extension MySize on int {
  SizedBox get he => SizedBox(height: toDouble());
  SizedBox get wi => SizedBox(width: toDouble());
}

extension Tcase on String {
  String get tcase => replaceFirst(
        this[0],
        this[0].toUpperCase(),
      );
}
