class DeathCount {
  int deathCount;
  String name;

  DeathCount(int deathCount, String name) {
    this.deathCount = deathCount;
    this.name = name;
  }

  DeathCount.fromJson(Map json) {
    deathCount = json['deathCount'];
    name = json['name'];
  }
}
