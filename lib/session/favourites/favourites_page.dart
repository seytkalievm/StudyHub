import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/color_codes.dart';
import 'favourites_controller.dart';

class FavouritesPage extends GetView<FavouritesController> {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: const Center(
        child: Text(
          "Favourites Page",
          style: TextStyle(
            color: unselectedTabColor,
          ),
        ),
      ),
    );
  }
}
