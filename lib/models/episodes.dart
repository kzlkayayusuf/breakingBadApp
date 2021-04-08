class Episode {
  int id;
  String title, season, airDate, episode, series;
  List characters;

  Episode(int id, String title, String season, String airDate, String episode,
      String series, List characters) {
    this.id = id;
    this.title = title;
    this.season = season;
    this.airDate = airDate;
    this.episode = episode;
    this.series = series;
    this.characters = characters;
  }

  Episode.fromJson(Map json) {
    id = json['episode_id'];
    title = json['title'];
    season = json['season'];
    airDate = json['airDate'];
    episode = json['episode'];
    series = json['series'];
    characters = json['characters'];
  }

  Map toJson() {
    return {
      "id": id,
      "title": title,
      "season": season,
      "airDate": airDate,
      "episode": episode,
      "series": series,
    };
  }
}
