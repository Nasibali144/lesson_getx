import 'package:get/get.dart';
import 'package:lesson_getx/page/detail/detail_controller.dart';
import 'package:lesson_getx/page/home/home_controller.dart';

class DIService {

  static void init() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<DetailController>(() => DetailController(), fenix: true);
  }
}