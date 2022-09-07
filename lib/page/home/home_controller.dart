import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:lesson_getx/model/post_model.dart';
import 'package:lesson_getx/service/network_service.dart';

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
}