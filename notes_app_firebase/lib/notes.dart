class Notes {
  String not_id;
  String ders_adi;
  int not1;
  int not2;

  Notes(this.not_id, this.ders_adi, this.not1, this.not2);
  factory Notes.fromJson(String key, Map<dynamic, dynamic> json) {
    return Notes(key, json["ders_adi"] as String, json["not2"] as int,
        json["not1"] as int);
  }
}
