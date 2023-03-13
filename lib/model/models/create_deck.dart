import 'create_card.dart';

class CreateDeck {
  final int folderId;
  final String deckName;
  final String semester;
  List<CreateCard> cards = [];

  CreateDeck({
    required this.folderId,
    required this.deckName,
    required this.semester,
  });

  Map<String, Object?> toJson() {
    List<Map<String, Object?>> cards = [];

    for (int i = 0; i < this.cards.length; i++) {
      cards.add(this.cards[i].toJson(i));
    }

    var json = {
      "folder_id": 1,
      "deck_name": deckName,
      "semester": semester,
      "cards": cards,
    };

    return json;
  }
}
