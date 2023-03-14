import 'package:get/get.dart';
import '../../../../domain/use_case/deck/get_for_you_use_case.dart';
import '../../../../model/models/folder.dart';

class ForYouController extends GetxController {
  List<Folder> folders = [];
  bool isEmpty = true;
  bool isLoading = true;

  ForYouController() {
    getFolders();
  }

  void getFolders() async {
    folders = await GetForYouUseCase.invoke();
    isEmpty = folders.isEmpty;
    isLoading = false;
    update();
  }
}
