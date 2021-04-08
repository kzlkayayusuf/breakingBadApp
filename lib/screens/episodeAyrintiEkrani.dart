import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad/apis/api.dart';
import 'package:breakingbad/functions/card.dart';
import 'package:breakingbad/models/episodes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EpisodeAyrinti extends StatefulWidget {
  final int id;
  EpisodeAyrinti({this.id});
  @override
  _EpisodeAyrintiState createState() => _EpisodeAyrintiState();
}

class _EpisodeAyrintiState extends State<EpisodeAyrinti> {
  Episode bolum;
  bool loading = false;
  void bolumGetir() {
    Api.getEpisodesDetail(widget.id).then((response) {
      var data = json.decode(response.body);
      setState(() {
        bolum = Episode(
          data[0]['episode_id'],
          data[0]['title'] == null ? 'Bilinmiyor' : data[0]['title'],
          data[0]['season'] == null ? 'Bilinmiyor' : data[0]['season'],
          data[0]['airDate'] == null ? 'Bilinmiyor' : data[0]['airDate'],
          data[0]['episode'] == null ? 'Bilinmiyor' : data[0]['episode'],
          data[0]['series'] == null ? 'Bilinmiyor' : data[0]['series'],
          data[0]['characters'] == null ? 'Bilinmiyor' : data[0]['characters'],
        );

        loading = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    bolumGetir();
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
                  TypewriterAnimatedText('${bolum.title}'),
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
                    bolum.episode,
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
                      cardOlusturucu('Başlık: ', bolum.title, context),
                      cardOlusturucu('Sezon: ', bolum.season, context),
                      cardOlusturucu(
                          'Yayınlanma Tarih: ', bolum.airDate, context),
                      cardOlusturucu('Bölüm: ', bolum.episode, context),
                      cardOlusturucu('Seri: ', bolum.series, context),
                      for (String character in bolum.characters)
                        cardOlusturucu('Karakter Adı: ', character, context),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
