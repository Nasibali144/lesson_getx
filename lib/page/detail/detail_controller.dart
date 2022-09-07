import 'package:flutter/material.dart';
import 'package:lesson_getx/model/post_model.dart';
import 'package:lesson_getx/page/home/home_controller.dart';
import 'package:lesson_getx/service/network_service.dart';
import 'package:get/get.dart';
import 'package:lesson_getx/service/util_service.dart';

enum Status {
  create,
  update,
}

class DetailController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  Rx<Status> status = Status.create.obs;
  RxBool isLoading = false.obs;
  Rx<Post>? post;

  void init(Post post) {
    this.post = post.obs;
    titleController.text = post.title;
    bodyController.text = post.body;
    status.value = Status.update;
  }

  void save() {
    if(status.value == Status.create) {
      _createPost();
    } else {
      _updatePost();
    }
  }

  void _createPost() async{
    isLoading.value = true;

    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    Post post = Post(id: "01", title: title, body: body, userId: 1);
    var response = await NetworkService.POST(NetworkService.API_CREATE, NetworkService.bodyCreate(post));

    isLoading.value = false;

    if(response != null) {
      var home = Get.find<HomeController>();
      home.getAllPost();
      Get.back();
    } else {
      Utils.fireSnackGetX("Please try again, Something error!");
    }
  }

  void _updatePost() async {
    isLoading.value = true;

    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    post!.value.title = title;
    post!.value.body = body;
    var response = await NetworkService.PUT(NetworkService.API_UPDATE + post!.value.id, NetworkService.bodyUpdate(post!.value));

    isLoading.value = false;

    if(response != null) {
      var home = Get.find<HomeController>();
      int index = home.posts.indexOf(post!.value);
      home.posts[index] = post!.value;
      Get.back();
    } else {
      Utils.fireSnackGetX("Please try again, Something error!");
    }
  }
}