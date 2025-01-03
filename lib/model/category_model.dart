import 'package:flutter/services.dart';

class CategoryModel {
  int? id;
  String? name;
  Uint8List? image;

  CategoryModel({required this.id, required this.name, required this.image});

  factory CategoryModel.fromMap(Map m1) {
    return CategoryModel(
      id: m1['cat_id'],
      name: m1['cat_name'],
      image: m1['cat_image'],
    );
  }
}
