import 'package:get/get.dart';
import '../../domain/repository/local/cached_repo_impl.dart';
import '../../domain/repository/remote/deck_repository_impl.dart';
import '../../model/repository/cached_repository.dart';
import '../../model/repository/deck_repository.dart';
import 'home/home_controller.dart';
import 'profile/profile_controller.dart';
import 'create/create_deck_controller.dart';
import 'session_controller.dart';

class SessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionController>(() => SessionController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<CreateDeckController>(() => CreateDeckController());
    Get.put<DeckRepository>(DeckRepositoryImpl());
    Get.put<CachedRepository>(CachedRepoImpl());
  }
}
