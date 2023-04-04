class Words {
  String kelime_id;
  String ingilizce;
  String turkce;

  Words(this.kelime_id, this.ingilizce, this.turkce);

  factory Words.fromJson(String key, Map<dynamic, dynamic> json) {
    return Words(key, json["ingilizce"] as String, json["turkce"] as String);
  }
}
