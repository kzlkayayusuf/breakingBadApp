class DeathRandom {
  int id, season, episode;
  String death, cause, responsible, lastWords, nickname, img;
  List occupation;

  DeathRandom(
      int id,
      int season,
      int episode,
      String death,
      String cause,
      String responsible,
      String lastWords,
      String nickname,
      String img,
      List occupation) {
    this.id = id;
    this.season = season;
    this.episode = episode;
    this.nickname = nickname;
    this.death = death;
    this.cause = cause;
    this.responsible = responsible;
    this.lastWords = lastWords;
    this.img = img;
    this.occupation = occupation;
  }

  DeathRandom.fromJson(Map json) {
    id = json['death_id'];
    death = json['death'];
    cause = json['cause'];
    responsible = json['responsible'];
    lastWords = json['last_words'];
    season = json['season'];
    episode = json['episode'];
    occupation = json['occupation'];
    img = json['img'];
    nickname = json['nickname'];
  }
}
