class Notes {
  String not_id;
  String ders_adi;
  String not1;
  String not2;

  Notes(this.not_id, this.ders_adi, this.not1, this.not2);
  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(json["not_id"] as String, json["ders_adi"] as String,
        json["not1"] as String, json["not2"] as String);
  }
}
