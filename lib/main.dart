import 'package:flutter/material.dart';
import 'package:lesson_getx/page/home/home_page.dart';
import 'package:lesson_getx/service/di_service.dart';
import 'package:get/get.dart';

void main() {
  DIService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
