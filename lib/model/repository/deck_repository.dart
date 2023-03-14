import 'package:study_hub/model/models/create_deck.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/models/resource.dart';
import 'package:study_hub/model/models/search_result.dart';
import '../models/folder.dart';
import '../models/search_query.dart';

abstract class DeckRepository {
  Future<Resource<Deck>> uploadDeck(CreateDeck deck);
  Future<Resource<List<Deck>>> getDecks();
  Future<Resource<List<Deck>>> getFavourites();
  Future<Resource<int>> addToFavourites(Deck deck);
  Future<Resource<int>> removeFromFavourites(Deck deck);
  Future<Resource<List<Folder>>> getFolderList();
  Future<Resource<Deck>> uploadDeckFromSheet(CreateDeck deck, String link);
  Future<Resource<SearchResult>> search(SearchQuery query);
}
