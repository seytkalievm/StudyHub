import 'package:study_hub/model/models/create_deck.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/models/resource.dart';

abstract class DeckRepository {
  Future<Resource<Deck>> uploadDeck(CreateDeck deck, String accessToken);
  Future<Resource<List<Deck>>> getDecks(String accessToken);
  Future<Resource<List<Deck>>> getFavourites(String accessToken);
  Future<Resource<int>> addToFavourites(Deck deck);
  Future<Resource<int>> removeFromFavourites(Deck deck);
}
