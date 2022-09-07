import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lesson_getx/model/post_model.dart';
import 'package:lesson_getx/service/network_service.dart';

class HomeController extends GetxController {
  List<Post> posts = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getAllPost();
  }

  Future<void> getAllPost() async {
    isLoading = true;
    update();

    List? response = await NetworkService.GET(NetworkService.API_LIST, NetworkService.paramsEmpty()) as List?;
    posts = NetworkService.parsePostList(response!);

    isLoading = false;
    update();
  }
}