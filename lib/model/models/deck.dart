import 'card.dart';

class Deck {
  int id;
  int folderId;
  int authorId;
  String deckName;
  String semester;
  List<Card> cards;
  bool isFavourite;
  String folderName = "";

  Deck({
    required this.id,
    required this.folderId,
    required this.authorId,
    required this.deckName,
    required this.semester,
    required this.cards,
    required this.isFavourite,
  });

  static Deck fromJson(Map<String, Object?> jsonMap) {
    var cardsJson = jsonMap["cards"] as List;
    List<Card> cards = [];
    for (int i = 0; i < cardsJson.length; i++) {
      cards.add(Card.fromJson(cardsJson[i]));
    }

    return Deck(
      id: jsonMap["deck_id"] as int,
      folderId: jsonMap["folder_id"] as int,
      authorId: jsonMap["author_id"] as int,
      deckName: jsonMap["deck_name"] as String,
      semester: jsonMap["semester"] as String,
      isFavourite: jsonMap["is_favourite"] as bool,
      cards: cards,
    );
  }

  @override
  String toString() => "Deck($id $folderId $authorId $deckName $semester)";

  @override
  int get hashCode {
    return id * folderId * authorId * deckName.hashCode * semester.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (other is Deck) {
      return (id == other.id &&
          folderId == other.folderId &&
          authorId == other.authorId);
    }

    return false;
  }
}
