import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../model/models/deck.dart';
import '../../../presentation/session/check_knowledge/check_knowledge_page.dart';
import '../../../presentation/util/color_codes.dart';
import '../../../presentation/widgets/image_preview.dart';
import '../../../presentation/widgets/themed_material_button.dart';
import '../study/study_page.dart';
import 'deck_view_controller.dart';

class DeckViewPage extends StatelessWidget {
  final Deck deck;
  const DeckViewPage({required this.deck, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<DeckViewController>(
      DeckViewController(deck.folderId, deck.authorId),
    );

    var screenSize = MediaQuery.of(context).size;

    return GetBuilder<DeckViewController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(deck.deckName),
          elevation: 0,
        ),
        body: SafeArea(
          child: kIsWeb
              ? _webDeckView(controller, screenSize)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _infoField(
                      asset: "assets/icons/deck_view/folder.svg",
                      text: deck.folderName,
                    ),
                    _infoField(
                      asset: "assets/icons/deck_view/user.svg",
                      text: controller.authorName,
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
                        Get.to(() => CheckKnowledgePage(deck: deck));
                      },
                      color: selectedTabColor,
                    ),
                    ThemedMaterialButton(
                      text: "Overview",
                      callback: () {
                        Get.to(() => StudyPage(deck: deck));
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
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            asset,
            height: 20,
            width: 20,
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                text,
                style: defaultStyle,
              ),
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

  _webDeckView(DeckViewController controller, Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _webDeckInfoColumn(),
            _webDeckButtons(),
          ],
        ),
        _webNumberOfCards(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              top: 40,
              left: 105,
              right: 105,
              bottom: 20,
            ),
            child: webCards(screenSize),
          ),
        ),
      ],
    );
  }

  Widget _webDeckInfoColumn() {
    return Container(
      width: 500,
      margin: const EdgeInsets.only(top: 30, left: 85),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: _deckNameInfoField(),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _infoField(
              asset: "assets/icons/deck_view/folder.svg",
              text: deck.folderName,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _infoField(
              asset: "assets/icons/deck_view/user.svg",
              text: deck.authorId.toString(),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _infoField(
              asset: "assets/icons/deck_view/year.svg",
              text: deck.semester,
            ),
          ),
        ],
      ),
    );
  }

  Widget _deckNameInfoField() {
    return Text(
      deck.deckName,
      style: const TextStyle(
        fontSize: 20,
        fontFamily: "Roboto",
        color: Colors.white,
      ),
    );
  }

  Widget _webDeckButtons() {
    return Container(
      margin: const EdgeInsets.only(right: 85),
      child: Column(
        children: [
          ThemedMaterialButton(
            text: "Start",
            callback: () {
              Get.to(() => CheckKnowledgePage(deck: deck));
            },
            color: selectedTabColor,
          ),
          ThemedMaterialButton(
            text: "Overview",
            callback: () {
              Get.to(() => StudyPage(deck: deck));
            },
            color: purpleAppColor,
          ),
        ],
      ),
    );
  }

  Widget _webNumberOfCards() {
    String cardString = "";
    deck.cards.length == 1 ? cardString = "card" : cardString = "cards";

    return Container(
      width: 64,
      margin: const EdgeInsets.only(left: 105, top: 40),
      decoration: BoxDecoration(
        border: Border.all(color: greySecondary),
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
      child: Center(
        child: Text(
          "${deck.cards.length} $cardString",
          style: const TextStyle(
            color: greySecondary,
            fontSize: 12,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget webCards(Size screenSize) {
    return GridView.builder(
      itemCount: deck.cards.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenSize.width > 1500
            ? 4
            : screenSize.width > 1300
                ? 3
                : screenSize.width > 1000
                    ? 2
                    : 1,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return _singleDeckCard(index);
      },
    );
  }

  _singleDeckCard(int index) {
    return Card(
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          color: darkCard,
          borderRadius: BorderRadius.circular(3),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                deck.cards[index].question,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
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
      ),
    );
  }
}
