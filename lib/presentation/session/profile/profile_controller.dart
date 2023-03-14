import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'favourites/favourites_controller.dart';
import 'settings/settings_controller.dart';
import 'my_decks/my_decks_controller.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    Get.put<MyDecksController>(MyDecksController(), permanent: true);
    Get.put<SettingsController>(SettingsController(), permanent: true);
    Get.put<FavouritesController>(FavouritesController(), permanent: true);

    tabController = TabController(vsync: this, length: 3);
    super.onInit();
  }
}
