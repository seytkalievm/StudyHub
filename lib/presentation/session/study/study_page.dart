import 'package:study_hub/model/models/card.dart' as card;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_hub/presentation/session/study/study_controller.dart';
import 'package:study_hub/presentation/util/color_codes.dart';
import '../../widgets/image_preview.dart';

class StudyPage extends StatelessWidget {
  final List<card.Card> cards;
  const StudyPage({required this.cards, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<StudyController>(() => StudyController());

    return GetBuilder<StudyController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _header(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cards.length,
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

  Widget _numberOfCards() {
    String cardString = "";
    cards.length == 1 ? cardString = "card" : cardString = "cards";

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        "${cards.length} $cardString",
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: greySecondary,
          fontSize: 16,
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
    bool isAnswerPresent =
        cards[index].answer != null && cards[index].answer!.isNotEmpty ||
            cards[index].answerImageUrls != null;

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
                    cards[index].question,
                    style: _style,
                  ),
                ),
                cards[index].questionImageUrl == null
                    ? Container()
                    : imagePreview(cards[index].questionImageUrl!, 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _answer(BuildContext context, int i) {
    bool isTextPresent = cards[i].answer != null;
    bool areImagesPresent = cards[i].answerImageUrls != null &&
        cards[i].answerImageUrls!.isNotEmpty;

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
                          cards[i].answer!,
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
                          itemCount: cards[i].answerImageUrls!.length,
                          itemBuilder: (context, index) {
                            return imagePreview(
                              cards[i].answerImageUrls![index],
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
}
