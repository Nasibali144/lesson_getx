import 'package:flutter/material.dart';
import 'package:lesson_getx/page/detail/detail_binding.dart';
import 'package:lesson_getx/page/detail/detail_page.dart';
import 'package:lesson_getx/page/home/home_page.dart';
import 'package:get/get.dart';
import 'page/home/home_binding.dart';

void main() {
  // DIService.init();
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
      getPages: [
        GetPage(
          name: HomePage.id,
          page: () => const HomePage(),
          binding: HomeBinding(),
        ),

        GetPage(
          name: DetailPage.id,
          page: () => const DetailPage(),
          binding: DetailBinding(),
        ),
      ],
      initialRoute: HomePage.id,
    );
  }
}
