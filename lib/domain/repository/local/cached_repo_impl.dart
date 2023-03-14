import 'package:get/get.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/models/folder.dart';
import 'package:study_hub/model/repository/cached_repository.dart';
import 'package:study_hub/model/repository/deck_repository.dart';
import '../../../model/models/resource.dart';

class CachedRepoImpl implements CachedRepository {
  final DeckRepository remote = Get.find();
  final RxList<Deck> _favouriteDecks = RxList();
  final RxList<Deck> _myDecks = RxList();
  final RxList<Deck> _recentDecks = RxList();
  final RxList<Folder> _folderList = RxList();

  @override
  RxList<Deck> get favouriteDecks => _favouriteDecks;

  @override
  RxList<Deck> get myDecks => _myDecks;

  @override
  RxList<Deck> get recentDecks => _recentDecks;

  @override
  RxList<Folder> get folderList => _folderList;

  @override
  void addToFavourites({required Deck deck}) {
    _favouriteDecks.insert(0, deck);

    for (var temp in _myDecks) {
      if (temp.id == deck.id) {
        temp.isFavourite = true;
      }
    }
  }

  @override
  void deleteFromFavourites({required Deck deck}) {
    for (var temp in _favouriteDecks) {
      if (temp.id == deck.id) {
        _favouriteDecks.remove(temp);
        break;
      }
    }

    for (var temp in _myDecks) {
      if (temp.id == deck.id) {
        temp.isFavourite = false;
        break;
      }
    }
  }

  @override
  void uploadDeck({required Deck deck}) {
    _myDecks.insert(0, deck);
  }

  @override
  Future<void> updateMyDecks() async {
    var response = await remote.getDecks();
    if (response is Success) {
      for (var deck in response.data!) {
        _myDecks.insert(0, deck);
      }
    }
  }

  @override
  Future<void> updateFavourites() async {
    var response = await remote.getFavourites();
    if (response is Success) {
      for (var deck in response.data!) {
        _favouriteDecks.insert(0, deck);
      }
    }
  }

  @override
  Future<void> updateFolders() async {
    var response = await remote.getFolderList();
    if (response is Success) {
      for (var folder in response.data!) {
        _folderList.add(folder);
      }
    }
  }
}
