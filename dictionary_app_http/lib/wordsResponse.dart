import 'package:dictionary_app/words.dart';

class WordsResponse {
  int success;
  List<Words> wordList;

  WordsResponse(this.success, this.wordList);
  factory WordsResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["kelimeler"] as List;
    List<Words> wordList = jsonArray
        .map((jsonArrayObject) => Words.fromJson(jsonArrayObject))
        .toList();

    return WordsResponse(json["success"] as int, wordList);
  }
}
