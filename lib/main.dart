import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking_app/views/screens/home-page.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
      ],
    ),
  );
}
