import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad/apis/api.dart';
import 'package:breakingbad/functions/card.dart';
import 'package:breakingbad/models/quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class QuoteAyrinti extends StatefulWidget {
  final int id;
  QuoteAyrinti({this.id});
  @override
  _QuoteAyrintiState createState() => _QuoteAyrintiState();
}

class _QuoteAyrintiState extends State<QuoteAyrinti> {
  Quote _quotes;
  bool loading = false;
  void quoteGetir() {
    Api.getQuotesDetail(widget.id).then((response) {
      var data = json.decode(response.body);
      setState(() {
        _quotes = Quote(
          data[0]['quote_id'],
          data[0]['quote'] == null ? 'Bilinmiyor' : data[0]['quote'],
          data[0]['author'] == null ? 'Bilinmiyor' : data[0]['author'],
          data[0]['series'] == null ? 'Bilinmiyor' : data[0]['series'],
        );

        loading = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    quoteGetir();
  }

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? Scaffold(
            body: Center(
              child: SpinKitPulse(
                color: Colors.black,
                size: 150.0,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('${_quotes.author}'),
                ],
                repeatForever: true,
                pause: Duration(milliseconds: 1000),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    _quotes.id.toString(),
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                  width: 250.0,
                  child: Divider(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      cardOlusturucu('Söz: ', _quotes.quote, context),
                      cardOlusturucu('Yazar: ', _quotes.author, context),
                      cardOlusturucu('Seri: ', _quotes.series, context),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
