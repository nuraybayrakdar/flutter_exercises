class Words {
  String kelime_id;
  String ingilizce;
  String turkce;

  Words(this.kelime_id, this.ingilizce, this.turkce);

  factory Words.fromJson(Map<String, dynamic> json) {
    return Words(json["kelime_id"] as String, json["ingilizce"] as String,
        json["turkce"] as String);
  }
}
