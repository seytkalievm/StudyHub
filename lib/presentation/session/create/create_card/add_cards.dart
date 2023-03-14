import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/color_codes.dart';
import '../create_card/add_cards_controller.dart';
import '../single_card/single_card_view.dart';

class AddCardsPage extends StatelessWidget {
  const AddCardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCardsController>(builder: (controller) {
      return kIsWeb
          ? _web(controller, context)
          : Scaffold(
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

  _web(AddCardsController controller, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
        actions: [
          _finishButton(controller),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _cards(controller, context),
            _addButton(controller),
          ],
        ),
      ),
    );
  }

  Widget _cards(AddCardsController controller, BuildContext context) {
    return Container(
      margin:
          kIsWeb ? const EdgeInsets.only(left: 85, right: 85, top: 21) : null,
      child: ListView.builder(
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
      ),
    );
  }

  Widget _addButton(AddCardsController controller) {
    return Container(
      margin: kIsWeb
          ? const EdgeInsets.fromLTRB(105, 30, 105, 30)
          : const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
      margin: kIsWeb
          ? const EdgeInsets.fromLTRB(0, 15, 105, 15)
          : const EdgeInsets.fromLTRB(20, 30, 20, 15),
      width: kIsWeb ? 156 : null,
      height: kIsWeb ? 30 : 60,
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
            fontSize: kIsWeb ? 16 : 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
