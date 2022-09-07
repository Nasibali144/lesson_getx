import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lesson_getx/model/post_model.dart';
import 'package:lesson_getx/page/home/home_controller.dart';
import 'package:lesson_getx/view/post_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX Post"),
        centerTitle: true,
      ),
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  Post post = controller.posts[index];
                  return PostView(post: post);
                },
              ),

              Visibility(
                visible: controller.isLoading.value,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
