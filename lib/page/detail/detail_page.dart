import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson_getx/page/detail/detail_controller.dart';

class DetailPage extends StatelessWidget {
  static const id = "/detail_page";
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detailController = Get.find<DetailController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(detailController.status.value == Status.create ? "Post Create" : "Post Update"),
        actions: [
          IconButton(
            onPressed: detailController.save,
            icon: const Icon(Icons.save),
            color: Colors.white,
            iconSize: 30,
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: detailController.titleController,
                    decoration: const InputDecoration(
                      hintText: "Title"
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                    ),
                  ),

                  const SizedBox(height: 15,),

                  TextField(
                    controller: detailController.bodyController,
                    decoration: const InputDecoration(
                        hintText: "Content"
                    ),
                    maxLines: null,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
          ),

          Obx(() {
              return Visibility(
                visible: detailController.isLoading(),
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
