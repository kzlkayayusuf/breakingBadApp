import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad/apis/api.dart';
import 'package:breakingbad/functions/card.dart';
import 'package:breakingbad/models/deaths.dart';
import 'package:breakingbad/models/deathsRandom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_fade/image_fade.dart';

class DeathAyrinti extends StatefulWidget {
  final List name;
  DeathAyrinti({this.name});
  @override
  _DeathAyrintiState createState() => _DeathAyrintiState();
}

class _DeathAyrintiState extends State<DeathAyrinti> {
  var olum;

  bool loading = false;
  //bool random = false;

  void olumGetir() {
    widget.name[1] != "ölüm"
        ? Api.getDeathsWithName(widget.name).then((response) {
            var data = json.decode(response.body);
            setState(() {
              olum = Death(
                data[0]['death_id'],
                data[0]['season'] == null ? 'Bilinmiyor' : data[0]['season'],
                data[0]['episode'] == null ? 'Bilinmiyor' : data[0]['episode'],
                data[0]['number_of_deaths'] == null
                    ? 'Bilinmiyor'
                    : data[0]['number_of_deaths'],
                data[0]['death'] == null ? 'Bilinmiyor' : data[0]['death'],
                data[0]['cause'] == null ? 'Bilinmiyor' : data[0]['cause'],
                data[0]['responsible'] == null
                    ? 'Bilinmiyor'
                    : data[0]['responsible'],
                data[0]['last_words'] == null
                    ? 'Bilinmiyor'
                    : data[0]['last_words'],
              );

              loading = true;
            });
          })
        : Api.getDeathsDetail(widget.name).then((response) {
            var data = json.decode(response.body);
            setState(() {
              olum = DeathRandom(
                data['death_id'],
                data['season'] == null ? 'Bilinmiyor' : data['season'],
                data['episode'] == null ? 'Bilinmiyor' : data['episode'],
                data['death'] == null ? 'Bilinmiyor' : data['death'],
                data['cause'] == null ? 'Bilinmiyor' : data['cause'],
                data['responsible'] == null
                    ? 'Bilinmiyor'
                    : data['responsible'],
                data['last_words'] == null ? 'Bilinmiyor' : data['last_words'],
                data['nickname'] == null ? 'Bilinmiyor' : data['nickname'],
                data['img'] == null ? 'Bilinmiyor' : data['img'],
                data['occupation'] == null ? 'Bilinmiyor' : data['occupation'],
              );

              loading = true;
            });
          });
  }

  @override
  void initState() {
    super.initState();
    olumGetir();
  }

  @override
  Widget build(BuildContext context) {
    return widget.name[1] != "ölüm"
        ? loading == false
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
                      TypewriterAnimatedText('${olum.death}'),
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
                        olum.episode.toString(),
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
                          cardOlusturucu(
                              'Death ID: ', olum.id.toString(), context),
                          cardOlusturucu(
                              'Sezon: ', olum.season.toString(), context),
                          cardOlusturucu(
                              'Bölüm: ', olum.episode.toString(), context),
                          cardOlusturucu('Ölüm Sayısı: ',
                              olum.numberDeaths.toString(), context),
                          cardOlusturucu('Ölü ismi: ', olum.death, context),
                          cardOlusturucu('Ölüm Nedeni: ', olum.cause, context),
                          cardOlusturucu(
                              'Sorumlu: ', olum.responsible, context),
                          cardOlusturucu('Son Sözü: ', olum.lastWords, context),
                        ],
                      ),
                    ),
                  ],
                ),
              )
        : loading == false
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
                      TypewriterAnimatedText('${olum.death}'),
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
                      child: ImageFade(
                        image: NetworkImage(olum.img),
                        height: 200,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        fadeDuration: Duration(seconds: 5),
                        fadeCurve: Curves.bounceInOut,
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
                          cardOlusturucu(
                              'Death ID: ', olum.id.toString(), context),
                          cardOlusturucu(
                              'Sezon: ', olum.season.toString(), context),
                          cardOlusturucu(
                              'Bölüm: ', olum.episode.toString(), context),
                          cardOlusturucu('Ölü ismi: ', olum.death, context),
                          cardOlusturucu('Ölüm Nedeni: ', olum.cause, context),
                          cardOlusturucu(
                              'Sorumlu: ', olum.responsible, context),
                          cardOlusturucu('Son Sözü: ', olum.lastWords, context),
                          cardOlusturucu('Takma Adı: ', olum.nickname, context),
                          for (String meslek in olum.occupation)
                            cardOlusturucu('Meslek: ', meslek, context),
                        ],
                      ),
                    ),
                  ],
                ),
              );
  }
}
