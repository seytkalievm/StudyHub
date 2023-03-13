import 'package:flutter/cupertino.dart';

import 'card.dart';

class Deck {
  int id;
  int folderId;
  int authorId;
  String deckName;
  String semester;
  List<Card> cards;
  bool isFavourite = false;

  get folderName => folderId.toString();

  Deck({
    required this.id,
    required this.folderId,
    required this.authorId,
    required this.deckName,
    required this.semester,
    required this.cards,
  });

  static Deck fromJson(Map<String, Object?> jsonMap) {
    debugPrint(jsonMap.toString());
    var cardsJson = jsonMap["cards"] as List;
    List<Card> cards = [];
    for (int i = 0; i < cardsJson.length; i++) {
      cards.add(Card.fromJson(cardsJson[i]));
    }

    return Deck(
      id: jsonMap["id"] as int,
      folderId: jsonMap["folder_id"] as int,
      authorId: jsonMap["author_id"] as int,
      deckName: jsonMap["deck_name"] as String,
      semester: jsonMap["semester"] as String,
      cards: cards,
    );
  }

  @override
  String toString() => "Deck($id $folderId $authorId $deckName $semester)";
}
