import 'package:flutter/services.dart';

class DbModel {
  int? id;
  String category_name;
  Uint8List category_image;
  DbModel({
    this.id,
    required this.category_name,
    required this.category_image,
  });

  factory DbModel.fromSQL({required Map data}) {
    return DbModel(
      category_name: data['category_name'],
      category_image: data['category_image'],
      id: data['id'],
    );
  }
}
