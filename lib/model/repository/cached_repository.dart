import 'package:get/get.dart';
import '../models/deck.dart';
import '../models/folder.dart';

abstract class CachedRepository {
  RxList<Deck> get favouriteDecks;

  RxList<Deck> get myDecks;

  RxList<Deck> get recentDecks;

  RxList<Folder> get folderList;

  void addToFavourites({required Deck deck});

  void deleteFromFavourites({required Deck deck});

  void uploadDeck({required Deck deck});

  void logDeck({required Deck deck});

  Future<void> updateMyDecks();

  Future<void> updateFavourites();

  Future<void> updateFolders();

  Future<void> updateRecent();
}
