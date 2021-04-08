class Quote {
  int id;
  String quote, author, series;

  Quote(int id, String quote, String author, String series) {
    this.id = id;
    this.quote = quote;
    this.author = author;
    this.series = series;
  }

  Quote.fromJson(Map json) {
    id = json['quote_id'];
    quote = json['quote'];
    author = json['author'];
    series = json['series'];
  }
}
