import 'dart:ffi';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:lesson_getx/model/post_model.dart';
import 'package:lesson_getx/page/detail/detail_controller.dart';
import 'package:lesson_getx/page/detail/detail_page.dart';
import 'package:lesson_getx/service/network_service.dart';
import 'package:lesson_getx/service/util_service.dart';

class HomeController extends GetxController {
  RxList<Post> posts = <Post>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllPost();
  }

  Future<void> getAllPost() async {
    isLoading.value = true;

    List? response = await NetworkService.GET(NetworkService.API_LIST, NetworkService.paramsEmpty()) as List?;
    posts.value = NetworkService.parsePostList(response!);

    isLoading.value = false;
  }

  void createPost() {
    Get.to(() => const DetailPage());
  }

  void editPost(Post post) {
    Get.find<DetailController>().init(post);
    Get.to(() => const DetailPage());
  }

  void deletePost(Post post) async {
    isLoading.value = true;
    var response = await NetworkService.DELETE(NetworkService.API_DELETE + post.id, NetworkService.paramsEmpty());
    if(response != null) {
      posts.remove(post);
    } else {
      Utils.fireSnackGetX("Please try again, Something error!");
    }
    isLoading.value = false;
  }
}