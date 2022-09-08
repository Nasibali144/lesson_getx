import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson_getx/model/post_model.dart';
import 'package:lesson_getx/page/home/home_controller.dart';
import 'package:lesson_getx/view/post_view.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  static const id = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX Post"),
        centerTitle: true,
      ),
      body: Obx(() {
          return Stack(
            children: [
              ListView.builder(
                itemCount: homeController.posts.length,
                itemBuilder: (context, index) {
                  Post post = homeController.posts[index];
                  return PostView(post: post);
                },
              ),

              Visibility(
                visible: homeController.isLoading.value,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              )
            ],
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: homeController.createPost,
        child: const Icon(Icons.add),
      ),
    );
  }
}
