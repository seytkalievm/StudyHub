import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_hub/common/constants.dart';
import 'package:study_hub/model/models/create_deck.dart';
import 'package:study_hub/model/models/deck.dart';
import 'package:study_hub/model/models/resource.dart';
import 'package:study_hub/model/repository/auth_repository.dart';
import 'package:study_hub/model/repository/deck_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class DeckRepositoryImpl implements DeckRepository {
  final AuthRepository authRepo = Get.find();

  Future<Resource<Map<String, String>>> getAuthorizationHeader() async {
    var response = await authRepo.refresh();
    if (response is Success) {
      return Success(
          successData: {"Authorization": "Bearer ${response.data!}"});
    }

    return Fail(errorMessage: "couldn't update access token");
  }

  @override
  Future<Resource<Deck>> uploadDeck(CreateDeck deck, String accessToken) async {
    http.StreamedResponse? response;
    final url = Uri.parse("$serverIP/deck/create/");
    final data = jsonEncode(deck.toJson());
    var credentialsResponse = await getAuthorizationHeader();
    if (credentialsResponse is Fail) {
      return Fail(errorMessage: credentialsResponse.message!);
    }

    var credentials = credentialsResponse.data!;

    try {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(credentials);
      List<http.MultipartFile> files = await collectImages(deck);

      request.files.addAll(files);
      request.fields.addAll({"data": data.toString()});

      response = await request.send();

      if (response.statusCode != 201) {
        return Fail(
          statusCode: response.statusCode,
          errorMessage: await response.stream.bytesToString(),
        );
      }

      var deckStr = await response.stream.bytesToString();
      var newDeck = Deck.fromJson(json.decode(deckStr));

      return Success(successData: newDeck);
    } catch (error) {
      debugPrint("deck repository, uploadDeck 64. Error: ${error.toString()}");

      return Fail(errorMessage: error.toString());
    }
  }

  Future<List<http.MultipartFile>> collectImages(CreateDeck deck) async {
    List<http.MultipartFile> files = [];
    for (var card in deck.cards) {
      if (card.questionImage != null) {
        var file = await http.MultipartFile.fromPath(
          card.questionImageKey!,
          card.questionImage!,
          contentType: MediaType('image', 'jpg'),
        );
        files.add(file);
      }

      if (card.answerImages != null) {
        for (var i = 0; i < card.answerImages!.length; i++) {
          var file = await http.MultipartFile.fromPath(
            card.answerImageKeys![i],
            card.answerImages![i],
            contentType: MediaType('image', 'jpg'),
          );
          files.add(file);
        }
      }
    }

    return files;
  }

  @override
  Future<Resource<List<Deck>>> getDecks(String accessToken) async {
    return requestForDeck(url: Uri.parse("$serverIP/user/decks/get/"));
  }

  @override
  Future<Resource<List<Deck>>> getFavourites(String accessToken) {
    return requestForDeck(url: Uri.parse("$serverIP/user/favourite/get/"));
  }

  Future<Resource<List<Deck>>> requestForDeck({
    required Uri url,
  }) async {
    var credentialsResponse = await getAuthorizationHeader();
    if (credentialsResponse is Fail) {
      return Fail(errorMessage: credentialsResponse.message!);
    }

    var credentials = credentialsResponse.data!;
    http.Response response;

    try {
      response = await http.get(url, headers: credentials);
    } catch (error) {
      debugPrint("deck repository, getDecks. Error: ${error.toString()}");

      return Fail(errorMessage: error.toString());
    }

    var statusCode = response.statusCode;

    if (statusCode == 200) {
      List<Deck> decks = [];
      List decksListJson = json.decode(response.body);

      for (var deckJson in decksListJson) {
        decks.add(Deck.fromJson(deckJson));
      }

      return Success(successData: decks);
    } else {
      return Fail(errorMessage: response.body);
    }
  }

  @override
  Future<Resource<int>> addToFavourites(Deck deck) async {
    var credentialsResponse = await getAuthorizationHeader();
    if (credentialsResponse is Fail) {
      return Fail(errorMessage: credentialsResponse.message!);
    }
    var headers = {"Content-Type": "application/json"};
    var credentials = credentialsResponse.data!;

    headers.addAll(credentials);
    var url = Uri.parse("$serverIP/user/favourite/add/");

    var body = json.encode({"deck_id": deck.id}).toString();
    debugPrint(body.toString());
    http.Response response;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      return Fail(errorMessage: e.toString());
    }

    int statusCode = response.statusCode;
    if (statusCode == 201) {
      debugPrint("added deck ${deck.id} to favourites");

      return Success(successData: statusCode);
    } else {
      debugPrint(
        "Couldn't add deck to favourites: $statusCode, ${response.body}",
      );
      if (statusCode == 403) {
        return Fail(errorMessage: "Deck is already in favourites");
      }

      return Fail(errorMessage: "Unexpected error");
    }
  }

  @override
  Future<Resource<int>> removeFromFavourites(Deck deck) async {
    var credentialsResponse = await getAuthorizationHeader();
    if (credentialsResponse is Fail) {
      return Fail(errorMessage: credentialsResponse.message!);
    }

    var credentials = credentialsResponse.data!;

    var headers = {"Content-Type": "application/json"};
    headers.addAll(credentials);
    var url = Uri.parse("$serverIP/user/favourite/remove/");

    var body = json.encode({"deck_id": deck.id}).toString();

    http.Response response;

    try {
      response = await http.post(url, headers: headers, body: body);
    } catch (e) {
      return Fail(errorMessage: e.toString());
    }

    int statusCode = response.statusCode;
    if (statusCode == 201) {
      debugPrint("removed deck ${deck.id} from favourites");

      return Success(successData: statusCode);
    } else {
      debugPrint("removed deck ${deck.id} from favourites");
      if (statusCode == 403) {
        return Fail(errorMessage: "Deck is already not favourite");
      }

      return Fail(errorMessage: "Unexpected error");
    }
  }
}
