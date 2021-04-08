import 'package:http/http.dart' as http;

class Api {
  static Future getCharacters() {
    return http.get(Uri.parse("https://breakingbadapi.com/api/characters"));
  }

  static Future getCharactersDetail(int id) {
    if (id == -1) {
      return http
          .get(Uri.parse('https://breakingbadapi.com/api/character/random'));
    } else {
      return http
          .get(Uri.parse('https://breakingbadapi.com/api/characters/$id'));
    }
  }

  static Future getCharactersCategory(List series) {
    if (series[1] == "Bad") {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/characters?category=${series[0]}+${series[1]}'));
    } else if (series[2] == "Saul") {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/characters?category=${series[0]}+${series[1]}+${series[2]}'));
    } else {
      return null;
    }
  }

  static Future getCharactersWithLimit(int limit, int offset) {
    return http.get(Uri.parse(
        'https://breakingbadapi.com/api/characters?limit=$limit&offset=$offset'));
  }

  static Future getCharactersWithName(List name) {
    if (name[0].isNotEmpty && name[1].isNotEmpty) {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/characters?name=${name[0]}+${name[1]}'));
    } else if (name[0].isNotEmpty) {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/characters?name=${name[0]}'));
    }
  }

  static Future getEpisodes() {
    return http.get(Uri.parse('https://breakingbadapi.com/api/episodes'));
  }

  static Future getEpisodesDetail(int id) {
    return http.get(Uri.parse('https://breakingbadapi.com/api/episodes/$id'));
  }

  static Future getEpisodesCategory(List series) {
    if (series[1] == "Bad") {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/episodes?series=${series[0]}+${series[1]}'));
    } else if (series[2] == "Saul") {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/episodes?series=${series[0]}+${series[1]}+${series[2]}'));
    } else {
      return null;
    }
  }

  static Future getQuotes() {
    return http.get(Uri.parse('https://breakingbadapi.com/api/quotes'));
  }

  static Future getQuotesDetail(int id) {
    if (id == -1) {
      return http.get(Uri.parse('https://breakingbadapi.com/api/quote/random'));
    } else {
      return http.get(Uri.parse('https://breakingbadapi.com/api/quotes/$id'));
    }
  }

  static Future getQuotesCategory(List series) {
    if (series[1] == "Bad") {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/quote?series=${series[0]}+${series[1]}'));
    } else if (series[2] == "Saul") {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/quote?series=${series[0]}+${series[1]}+${series[2]}'));
    } else {
      return null;
    }
  }

  static Future getQuotesWithName(List name, bool author) {
    if (author == true) {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/quote?author=${name[0]}+${name[1]}'));
    } else {
      return http.get(Uri.parse(
          'https://breakingbadapi.com/api/quote/random?author=${name[0]}+${name[1]}'));
    }
  }

  static Future getDeaths() {
    return http.get(Uri.parse('https://breakingbadapi.com/api/deaths'));
  }

  static Future getDeathsDetail(List name) {
    if (name[1] == "ölüm") {
      return http.get(Uri.parse('https://breakingbadapi.com/api/random-death'));
    } else {
      return http.get(Uri.parse('https://breakingbadapi.com/api/death-count'));
    }
  }

  static Future getDeathsWithName(List name) {
    return http.get(Uri.parse(
        'https://breakingbadapi.com/api/death?name=${name[0]}+${name[1]}'));
  }

  static Future getDeathsCount(List name) {
    return http.get(Uri.parse(
        'https://breakingbadapi.com/api/death-count?name=${name[0]}+${name[1]}'));
  }
}
