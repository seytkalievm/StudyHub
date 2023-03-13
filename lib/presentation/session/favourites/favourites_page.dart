import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/color_codes.dart';
import '../deck_preview/deck_preview.dart';
import 'favourites_controller.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<FavouritesController>(() => FavouritesController());

    return GetBuilder<FavouritesController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              _searchBar(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.decks.length,
                itemBuilder: (context, index) {
                  return DeckPreview(deck: controller.decks[index]);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 48,
        child: TextField(
          onChanged: (value) => {},
          decoration: const InputDecoration(
            filled: true,
            fillColor: mainAppColor,
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: greySecondary,
            ),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintStyle: TextStyle(fontSize: 16, color: unselectedTabColor),
            hintText: "Search for a deck or course",
          ),
          style: const TextStyle(fontSize: 18, color: greySecondary),
          cursorColor: greySecondary,
        ),
      ),
    );
  }
}
