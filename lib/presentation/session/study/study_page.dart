import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../model/models/deck.dart';
import '../../../presentation/session/study/study_controller.dart';
import '../../../presentation/util/color_codes.dart';
import '../../widgets/image_preview.dart';

class StudyPage extends StatelessWidget {
  //final List<card.Card> cards;
  final Deck deck;

  const StudyPage({required this.deck, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<StudyController>(() => StudyController());

    return GetBuilder<StudyController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: kIsWeb
              ? _webStudyPage(controller)
              : Column(
                  children: [
                    _header(),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: deck.cards.length,
                        itemBuilder: (context, index) {
                          return _card(context, index);
                        },
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _cancelButton(),
        _numberOfCards(),
        const SizedBox(width: 60),
      ],
    );
  }

  Widget _cancelButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          iconSize: 20,
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            "assets/icons/deck_view/close.svg",
          ),
        ),
      ),
    );
  }

  Widget _webHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _webCancelButton(),
        _numberOfCards(),
        _downloadButton(),
      ],
    );
  }

  Widget _webCancelButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            IconButton(
              iconSize: 20,
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(
                "assets/icons/deck_view/close.svg",
              ),
            ),
            _webDeckName(),
          ],
        ),
      ),
    );
  }

  Widget _numberOfCards() {
    String cardString = "";
    deck.cards.length == 1 ? cardString = "card" : cardString = "cards";

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        "${deck.cards.length} $cardString",
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: greySecondary,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _downloadButton() {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          iconSize: 20,
          onPressed: () {
            //TODO
          },
          icon: SvgPicture.asset(
            "assets/icons/deck_view/download.svg",
          ),
        ),
      ),
    );
  }

  final TextStyle _style = const TextStyle(
    fontWeight: FontWeight.w400,
    color: selectedMenuColor,
    fontSize: 16,
  );

  Widget _card(BuildContext context, int index) {
    bool isAnswerPresent = deck.cards[index].answer != null &&
            deck.cards[index].answer!.isNotEmpty ||
        deck.cards[index].answerImageUrls != null;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      decoration: BoxDecoration(
        color: darkCard,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          _question(index),
          isAnswerPresent ? _answer(context, index) : Container(),
        ],
      ),
    );
  }

  Widget _question(int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/create_cards/create_card_question_mark.svg",
            color: unselectedMenuColor,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    deck.cards[index].question,
                    style: _style,
                  ),
                ),
                deck.cards[index].questionImageUrl == null
                    ? Container()
                    : imagePreview(deck.cards[index].questionImageUrl!, 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _answer(BuildContext context, int i) {
    bool isTextPresent = deck.cards[i].answer != null;
    bool areImagesPresent = deck.cards[i].answerImageUrls != null &&
        deck.cards[i].answerImageUrls!.isNotEmpty;

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/create_cards/create_card_answer_tick.svg",
            color: unselectedMenuColor,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !isTextPresent
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          deck.cards[i].answer!,
                          style: _style,
                        ),
                      ),
                !areImagesPresent
                    ? Container()
                    : SizedBox(
                        height: 70,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: deck.cards[i].answerImageUrls!.length,
                          itemBuilder: (context, index) {
                            return imagePreview(
                              deck.cards[i].answerImageUrls![index],
                              50,
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _webStudyPage(StudyController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(90, 10, 90, 30),
      child: Column(
        children: [
          _webHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: deck.cards.length,
              itemBuilder: (context, index) {
                return _card(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  _webDeckName() {
    return Text(
      deck.deckName,
      style: const TextStyle(
        color: selectedMenuColor,
        fontSize: 20,
      ),
    );
  }
}
