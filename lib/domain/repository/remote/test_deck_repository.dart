import 'package:study_hub/model/models/create_deck.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/models/folder.dart';
import 'package:study_hub/model/models/resource.dart';
import 'package:study_hub/model/models/search_query.dart';
import 'package:study_hub/model/models/search_result.dart';
import 'package:study_hub/model/repository/deck_repository.dart';

class TestDeckRepository implements DeckRepository {
  final deck = Deck(
    id: 0,
    folderId: 0,
    authorId: 0,
    deckName: "Test Deck",
    semester: "F00",
    cards: [],
    isFavourite: true,
  );

  @override
  Future<Resource<int>> addToFavourites(Deck deck) async {
    return Success(successData: 201);
  }

  @override
  Future<Resource<String>> getAuthorName(int authorId) async {
    return Success(successData: "Author");
  }

  @override
  Future<Resource<List<Deck>>> getDecks() async {
    return Success(successData: [deck, deck]);
  }

  @override
  Future<Resource<List<Deck>>> getDecksFromFolder(int folderId) async {
    var deck1 = deck;
    deck1.folderId = folderId;

    return Success(successData: [deck1, deck1]);
  }

  @override
  Future<Resource<List<Deck>>> getFavourites() async {
    return Success(successData: [deck, deck]);
  }

  @override
  Future<Resource<List<Folder>>> getFolderList() async {
    return Success(
      successData: [
        Folder(id: 1, name: "Folder 1"),
        Folder(id: 2, name: "Folder 2"),
        Folder(id: 3, name: "Folder 3"),
      ],
    );
  }

  @override
  Future<Resource<List<Folder>>> getForYou() async {
    return Success(
      successData: [
        Folder(id: 1, name: "Folder 1"),
        Folder(id: 2, name: "Folder 2"),
        Folder(id: 3, name: "Folder 3"),
      ],
    );
  }

  @override
  Future<Resource<List<Deck>>> getRecent() async {
    return Success(successData: [deck, deck]);
  }

  @override
  Future<Resource<int>> logDeck(int id) async {
    return Success(successData: 200);
  }

  @override
  Future<Resource<int>> removeFromFavourites(Deck deck) async {
    return Success(successData: 200);
  }

  @override
  Future<Resource<SearchResult>> search(SearchQuery query) async {
    return Success(
      successData: SearchResult(
        folders: [
          Folder(id: 1, name: "Folder 1"),
          Folder(id: 2, name: "Folder 2"),
          Folder(id: 3, name: "Folder 3"),
        ],
        decks: [deck, deck, deck],
      ),
    );
  }

  @override
  Future<Resource<Deck>> uploadDeck(CreateDeck deck) async {
    return Success(
      successData: Deck(
        id: 0,
        folderId: deck.folderId,
        authorId: 0,
        deckName: deck.deckName,
        semester: deck.semester,
        cards: [],
        isFavourite: false,
      ),
    );
  }

  @override
  Future<Resource<Deck>> uploadDeckFromSheet(
      CreateDeck deck, String link) async {
    return Success(
      successData: Deck(
        id: 0,
        folderId: deck.folderId,
        authorId: 0,
        deckName: deck.deckName,
        semester: deck.semester,
        cards: [],
        isFavourite: false,
      ),
    );
  }
}
