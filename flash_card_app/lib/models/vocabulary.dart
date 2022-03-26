class Vocabulary {
  String? id;
  String? ipa;
  String? word;
  String? definition;
  String? example;
  bool? isRemembered;
  bool? isFavorite;
  List<String>? synonyms;
  List<String>? type;
  String? uid;

  Vocabulary({
    this.id,
    this.ipa,
    this.word,
    this.definition,
    this.example,
    this.isRemembered,
    this.isFavorite,
    this.type,
    this.uid,
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) => Vocabulary(
        id: json["id"],
        ipa: json["ipa"],
        word: json["word"],
        definition: json["definition"],
        example: json["example"],
        isRemembered: json["isRemembered"] ?? false,
        isFavorite: json["isFavorite"] ?? false,
        type: json["type"] == null
            ? []
            : List<String>.from(json["type"].map((x) => x)),
        uid: json["uid"],
      );

  toJson() => {
        "id": id,
        "ipa": ipa,
        "word": word,
        "definition": definition,
        "example": example,
        "isRemembered": isRemembered,
        "isFavorite": isFavorite,
        "type": type,
        "uid": uid,
        "isDeleted": false,
      };
}
