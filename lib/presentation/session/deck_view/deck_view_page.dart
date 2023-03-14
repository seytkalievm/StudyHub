import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/presentation/session/check_knowledge/check_knowledge_page.dart';
import 'package:study_hub/presentation/util/color_codes.dart';
import 'package:study_hub/presentation/widgets/image_preview.dart';
import 'package:study_hub/presentation/widgets/themed_material_button.dart';
import '../study/study_page.dart';
import 'deck_view_controller.dart';

class DeckViewPage extends StatelessWidget {
  final Deck deck;
  const DeckViewPage({required this.deck, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<DeckViewController>(() => DeckViewController());

    return GetBuilder<DeckViewController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(deck.deckName),
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _infoField(
                asset: "assets/icons/deck_view/folder.svg",
                text: deck.folderName,
              ),
              _infoField(
                asset: "assets/icons/deck_view/user.svg",
                text: deck.authorId.toString(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoField(
                    asset: "assets/icons/deck_view/year.svg",
                    text: deck.semester,
                  ),
                  _numberOfCards(),
                ],
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.only(top: 35, left: 20),
                child: cards(),
              ),
              Expanded(child: Container()),
              ThemedMaterialButton(
                text: "Start",
                callback: () {
                  Get.to(() => CheckKnowledgePage(cards: deck.cards));
                },
                color: selectedTabColor,
              ),
              ThemedMaterialButton(
                text: "Overview",
                callback: () {
                  Get.to(() => StudyPage(cards: deck.cards));
                },
                color: purpleAppColor,
              ),
              SizedBox(
                height: 30,
                child: Container(),
              ),
            ],
          ),
        ),
      );
    });
  }

  final TextStyle defaultStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: greySecondary,
  );

  Widget _infoField({
    required String asset,
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            height: 20,
            width: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: defaultStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberOfCards() {
    String cardString = "";
    deck.cards.length == 1 ? cardString = "card" : cardString = "cards";

    return Container(
      margin: const EdgeInsets.only(right: 20, top: 20),
      decoration: BoxDecoration(
        border: Border.all(color: greySecondary),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: Text(
        "${deck.cards.length} $cardString",
        style: const TextStyle(
          color: greySecondary,
          fontSize: 12,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget cards() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: deck.cards.length,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            color: darkCard,
            borderRadius: BorderRadius.circular(3),
          ),
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      deck.cards[index].question,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              if (deck.cards[index].questionImageUrl != null)
                Expanded(
                  child: imagePreview(
                    deck.cards[index].questionImageUrl!,
                    50,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
