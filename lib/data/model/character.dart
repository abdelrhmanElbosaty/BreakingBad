class Character {
  late int id;
  late String charName;
  late String nickname;
  late List<dynamic> jobs;
  late String image;
  late String liveOrDead;
  late List<dynamic> appearance;
  late String charActualName;
  late String birthdate;
  late String category;
  late List<dynamic> betterCallSoulAppearance;

  Character.fromJson(Map<String, dynamic> json) {
    id = json["char_id"];
    charName = json["name"];
    nickname = json["nickname"];
    jobs = json["occupation"];
    image = json["img"];
    liveOrDead = json["status"];
    appearance = json["appearance"];
    charActualName = json["portrayed"];
    birthdate = json["birthday"];
    category = json["category"];
    betterCallSoulAppearance = json["better_call_saul_appearance"];
  }
}
