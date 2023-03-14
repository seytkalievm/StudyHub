import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../model/models/deck.dart';
import 'deck_preview_controller.dart';
import '../../../domain/use_case/deck/log_deck_use_case.dart';
import '../../util/color_codes.dart';
import '../deck_view/deck_view_page.dart';

class DeckPreview extends StatelessWidget {
  final Deck deck;
  const DeckPreview({required this.deck, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<DeckPreviewController>(DeckPreviewController());

    return GetBuilder<DeckPreviewController>(builder: (controller) {
      deck.folderName.isEmpty ? controller.setCourseName(deck) : null;

      return GestureDetector(
        onTap: () {
          LogDeckUseCase.invoke(deck);
          Get.to(() => DeckViewPage(deck: deck));
        },
        child: Container(
          decoration: BoxDecoration(
            color: darkCard,
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
              _courseName(deck.folderName),
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
                  // IconButton(
                  //   onPressed: () {
                  //     //TODO
                  //   },
                  //   padding: const EdgeInsets.only(right: 15, bottom: 10),
                  //   constraints: const BoxConstraints(),
                  //   icon: SvgPicture.asset(
                  //     "assets/icons/deck_preview/duplicate.svg",
                  //   ),
                  // ),
                  IconButton(
                    padding: const EdgeInsets.only(right: 15, bottom: 10),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      deck.isFavourite
                          ? controller.removeDeckFromFavourites(deck)
                          : controller.addDeckToFavourites(deck);
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

  Widget _courseName(String name) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Text(
        name,
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
