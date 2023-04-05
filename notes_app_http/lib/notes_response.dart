import 'package:notes_app_http/notes.dart';

class NotesResponse {
  int success;
  List<Notes> noteList;

  NotesResponse(this.success, this.noteList);

  factory NotesResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["notlar"] as List;
    List<Notes> noteList =
        jsonArray.map((jsonArrayObj) => Notes.fromJson(jsonArrayObj)).toList();
    return NotesResponse(json["success"] as int, noteList);
  }
}
