import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'for_you/for_you_controller.dart';
import 'recent/recent_controller.dart';
import 'search/search_controller.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    Get.lazyPut<RecentController>(() => RecentController());
    Get.lazyPut<ForYouController>(() => ForYouController());
    Get.lazyPut<SearchController>(() => SearchController());

    super.onInit();
  }
}
