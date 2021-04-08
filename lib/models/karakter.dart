class Karakter {
  int id;
  String name, img, birthday, status, nickname, portrayed, category;
  List occupation;

  Karakter(int id, String name, String img, String birthday, String portrayed,
      String status, String nickname, List occupation, String category) {
    this.id = id;
    this.name = name;
    this.img = img;
    this.birthday = birthday;
    this.status = status;
    this.nickname = nickname;
    this.portrayed = portrayed;
    this.occupation = occupation;
    this.category = category;
  }

  Karakter.fromJson(Map json) {
    id = json['char_id'];
    name = json['name'];
    img = json['img'];
    birthday = json['birthday'];
    status = json['status'];
    nickname = json['nickname'];
    portrayed = json['portrayed'];
    occupation = json['occupation'];
    category = json['category'];
  }

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "img": img,
      "birthday": birthday,
      "status": status,
      "nickname": nickname,
      "portrayed": portrayed,
      "occupation": occupation,
    };
  }
}
