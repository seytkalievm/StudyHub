import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/presentation/session/deck_preview/deck_preview_controller.dart';
import '../../util/color_codes.dart';

class DeckPreview extends StatelessWidget {
  final Deck deck;
  const DeckPreview({required this.deck, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<DeckPreviewController>(() => DeckPreviewController());

    void showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }

    return GetBuilder<DeckPreviewController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          //TODO: navigate to DeckPage
        },
        child: Container(
          decoration: BoxDecoration(
            color: mainAppColor,
            borderRadius: BorderRadius.circular(3),
          ),
          margin: const EdgeInsets.only(
            top: 12.5,
            left: 20,
            right: 20,
            bottom: 12.5,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _deckTitle(),
                    _numberOfCards(),
                  ],
                ),
              ),
              _courseName(),
              const Divider(
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: unselectedMenuColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _semester(),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    onPressed: () {
                      //TODO
                    },
                    padding: const EdgeInsets.only(right: 15, bottom: 10),
                    constraints: const BoxConstraints(),
                    icon: SvgPicture.asset(
                      "assets/icons/deck_preview/duplicate.svg",
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(right: 15, bottom: 10),
                    constraints: const BoxConstraints(),
                    onPressed: () async {
                      deck.isFavourite
                          ? await controller.removeDeckFromFavourites(deck)
                          : await controller.addDeckToFavourites(deck);

                      showSnackBar(controller.result);
                    },
                    icon: SvgPicture.asset(
                      deck.isFavourite
                          ? "assets/icons/deck_preview/favourite.svg"
                          : "assets/icons/deck_preview/add_to_favourites.svg",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _deckTitle() {
    return Text(
      deck.deckName,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _numberOfCards() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greySecondary),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: Text(
        deck.cards.length.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _courseName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Text(
        deck.folderName,
        style: const TextStyle(
          color: greySecondary,
          fontSize: 14,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _semester() {
    return Container(
      margin: const EdgeInsets.only(left: 16, bottom: 10),
      alignment: Alignment.center,
      child: Text(
        deck.semester,
        style: const TextStyle(
          color: greySecondary,
          fontSize: 14,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
