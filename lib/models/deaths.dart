class Death {
  int id, season, episode, numberDeaths;
  String death, cause, responsible, lastWords;

  Death(int id, int season, int episode, int numberDeaths, String death,
      String cause, String responsible, String lastWords) {
    this.id = id;
    this.season = season;
    this.episode = episode;
    this.numberDeaths = numberDeaths;
    this.death = death;
    this.cause = cause;
    this.responsible = responsible;
    this.lastWords = lastWords;
  }

  Death.fromJson(Map json) {
    id = json['death_id'];
    death = json['death'];
    cause = json['cause'];
    responsible = json['responsible'];
    lastWords = json['last_words'];
    season = json['season'];
    episode = json['episode'];
    numberDeaths = json['number_of_deaths'];
  }
}
