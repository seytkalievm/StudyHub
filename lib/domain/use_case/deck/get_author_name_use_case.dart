import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../model/models/resource.dart';
import '../../../model/repository/deck_repository.dart';

class GetAuthorNameUseCase {
  const GetAuthorNameUseCase._();

  static Future<String> invoke(int id) async {
    final DeckRepository remote = Get.find();

    var response = await remote.getAuthorName(id);
    if (response is Success) {
      debugPrint(response.data!);

      return response.data!;
    }

    return "Author name not specified";
  }
}
