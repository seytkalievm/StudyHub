import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'single_card_controller.dart';
import '../../../../model/models/create_card.dart';
import '../../../util/color_codes.dart';
import '../../../widgets/fullscreen_image_create.dart';

class SingleCardView extends StatelessWidget {
  final CreateCard card;
  final int index;
  final Function(CreateCard) delete;
  const SingleCardView({
    required this.card,
    Key? key,
    required this.index,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SingleCardController>(() => SingleCardController());

    return GetBuilder<SingleCardController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: mainAppColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _formFieldHeading("Question"),
                _deleteButton(delete),
              ],
            ),
            _formField(
              controller: card.questionController,
              asset: "assets/icons/create_cards/create_card_question_mark.svg",
              label: "Question",
              error: card.questionError,
            ),
            Row(
              children: [
                card.questionImage == null
                    ? _addImageButton(true, controller.update)
                    : const Center(),
                _imagePreview(card.questionImage, true, 0, controller.update),
              ],
            ),
            _formFieldHeading("Answer"),
            _formField(
              controller: card.answerController,
              asset: "assets/icons/create_cards/create_card_answer_tick.svg",
              label: "Answer",
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _imagePreviewList(controller.update),
                  _addImageButton(false, controller.update),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _formFieldHeading(String heading) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 15, left: 20),
        child: Text(
          heading,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _deleteButton(void Function(CreateCard) deleteCard) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: IconButton(
        onPressed: () {
          deleteCard(card);
        },
        icon: SvgPicture.asset(
          "assets/icons/create_cards/delete_card.svg",
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _formField({
    required TextEditingController controller,
    String? error,
    required String asset,
    required String label,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        style: const TextStyle(color: selectedMenuColor),
        keyboardType: TextInputType.multiline,
        cursorColor: unselectedMenuColor,
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          errorText: error,
          prefixIcon: SvgPicture.asset(
            asset,
            color: unselectedMenuColor,
            fit: BoxFit.scaleDown,
          ),
          labelText: label,
          labelStyle: const TextStyle(color: unselectedTabColor),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: unselectedTabColor),
          ),
        ),
      ),
    );
  }

  Widget _addImageButton(bool isQuestion, void Function() update) {
    String title = "Add image";
    if (!isQuestion && card.answerImages != null) {
      title = "Add";
    }
    ImagePicker picker = ImagePicker();

    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 15, 10, 20),
        height: 28,
        child: MaterialButton(
          color: purpleAppColor,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          onPressed: () async {
            XFile? im = await picker.pickImage(source: ImageSource.gallery);
            if (isQuestion) {
              card.questionImage = im!.path;
            } else {
              if (card.answerImages == null) {
                card.answerImages = [im!.path];
              } else {
                card.answerImages!.add(im!.path);
              }
            }
            update();
          },
        ),
      ),
    );
  }

  Widget _imagePreview(
    String? image,
    bool isQuestion,
    int i,
    Function() update,
  ) {
    var tag = "$index $isQuestion $i";

    return image != null
        ? Container(
            margin: const EdgeInsets.all(10),
            constraints: const BoxConstraints(
              maxHeight: 50,
              maxWidth: 300,
            ),
            child: GestureDetector(
              onTap: () {
                Get.to(() => FullscreenImageCreate(
                      card: card,
                      isQuestion: isQuestion,
                      index: i,
                      update: update,
                      heroTag: tag,
                    ));
              },
              child: Hero(
                tag: tag,
                child: Image(
                  image: FileImage(File(image)),
                  fit: BoxFit.scaleDown,
                  height: 50,
                ),
              ),
            ),
          )
        : const Center();
  }

  Widget _imagePreviewList(Function() update) {
    return card.answerImages == null
        ? Container()
        : SizedBox(
            height: 70,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: card.answerImages!.length,
              itemBuilder: (context, i) {
                return _imagePreview(
                  card.answerImages![i],
                  false,
                  i,
                  update,
                );
              },
            ),
          );
  }
}
