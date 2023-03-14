import 'deck.dart';
import 'folder.dart';

class SearchResult {
  final List<Folder> folders;
  final List<Deck> decks;

  SearchResult({required this.folders, required this.decks});

  static SearchResult fromJson(Map<String, Object?> json) {
    List<Folder> folders = [];
    List<Deck> decks = [];

    for (var deck in json["decks"] as List<dynamic>) {
      decks.add(Deck.fromJson(deck as Map<String, Object?>));
    }

    for (var folder in json["folders"] as List<dynamic>) {
      folders.add(Folder.fromJson(folder as Map<String, Object?>));
    }

    return SearchResult(folders: folders, decks: decks);
  }
}
