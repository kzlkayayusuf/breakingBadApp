import 'dart:convert';

import 'package:breakingbad/apis/api.dart';
import 'package:breakingbad/functions/card.dart';
import 'package:breakingbad/models/karakter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_fade/image_fade.dart';

class Ayrinti extends StatefulWidget {
  final int id;
  Ayrinti({this.id});

  @override
  _AyrintiState createState() => _AyrintiState();
}

class _AyrintiState extends State<Ayrinti> {
  Karakter k;
  bool loading = false;
  void karakterGetir() {
    Api.getCharactersDetail(widget.id).then((response) {
      var data = json.decode(response.body);
      setState(() {
        k = Karakter(
          data[0]['char_id'],
          data[0]['name'] == null ? 'Bilinmiyor' : data[0]['name'],
          data[0]['img'] == null ? 'Bilinmiyor' : data[0]['img'],
          data[0]['birthday'] == null ? 'Bilinmiyor' : data[0]['birthday'],
          data[0]['portrayed'] == null ? 'Bilinmiyor' : data[0]['portrayed'],
          data[0]['status'] == null ? 'Bilinmiyor' : data[0]['status'],
          data[0]['nickname'] == null ? 'Bilinmiyor' : data[0]['nickname'],
          data[0]['occupation'] == null ? 'Bilinmiyor' : data[0]['occupation'],
          data[0]['category'] == null ? 'Bilinmiyor' : data[0]['category'],
        );

        loading = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    karakterGetir();
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
                  TypewriterAnimatedText('${k.name}'),
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
                    image: NetworkImage(k.img),
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
                      cardOlusturucu('İsim: ', k.name, context),
                      cardOlusturucu('Oyuncu: ', k.portrayed, context),
                      cardOlusturucu('Takma Ad: ', k.nickname, context),
                      cardOlusturucu('Doğum Günü: ', k.birthday, context),
                      cardOlusturucu('Durum: ', k.status, context),
                      cardOlusturucu('Kategori: ', k.category, context),
                      for (String meslek in k.occupation)
                        cardOlusturucu('Meslek: ', meslek, context),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
