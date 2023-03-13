import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/color_codes.dart';
import 'create_controller.dart';

class CreatePage extends GetView<CreateController> {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),
      body: const Center(
        child: Text(
          "Create Page",
          style: TextStyle(color: unselectedTabColor),
        ),
      ),
    );
  }
}
