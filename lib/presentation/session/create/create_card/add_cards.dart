import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../single_card/single_card_view.dart';
import '../create_card/add_cards_controller.dart';
import '../../../util/color_codes.dart';

class AddCardsPage extends StatelessWidget {
  const AddCardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCardsController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Create"),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _cards(controller, context),
              _addButton(controller),
              _finishButton(controller),
            ],
          ),
        ),
      );
    });
  }

  Widget _cards(AddCardsController controller, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.cardModels.length,
      itemBuilder: (context, index) {
        return SingleCardView(
          index: index,
          card: controller.cardModels[index],
          delete: controller.deleteCard,
        );
      },
    );
  }

  Widget _addButton(AddCardsController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      height: 60,
      child: MaterialButton(
        onPressed: () {
          controller.addCard();
          controller.update();
        },
        color: mainAppColor,
        child: const Icon(
          Icons.add,
          color: selectedMenuColor,
        ),
      ),
    );
  }

  Widget _finishButton(AddCardsController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      height: 60,
      child: MaterialButton(
        onPressed: () {
          controller.finish();
          controller.update();
        },
        color: selectedTabColor,
        child: const Text(
          "Finish",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
