import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 4);
    super.onInit();
  }
}
