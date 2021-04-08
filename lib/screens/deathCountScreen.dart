import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad/apis/api.dart';
import 'package:breakingbad/functions/card.dart';
import 'package:breakingbad/models/deathCount.dart';
import 'package:flutter/material.dart';

class DeathCountScreen extends StatefulWidget {
  @override
  _DeathCountScreenState createState() => _DeathCountScreenState();
}

class _DeathCountScreenState extends State<DeathCountScreen> {
  List<DeathCount> deathcountListesi = [];
  bool loading = false;

  final _nameController = TextEditingController();
  String nameTutucu;

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            labelText: "İsim-Soyisim Giriniz: "),
                        keyboardType: TextInputType.text,
                        onChanged: (name) {
                          nameTutucu = name;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text(
                          'Listeyi getir',
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          deathCountGetir();
                          nameTutucu = "";
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('${deathcountListesi[0].name}'),
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
                  child: Text('${deathcountListesi[0].name}'),
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
                          'İsim: ', '${deathcountListesi[0].name}', context),
                      cardOlusturucu('Ölüm Sayısı: ',
                          '${deathcountListesi[0].deathCount}', context),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  void deathCountGetir() {
    List _getName;
    _getName = nameTutucu.split(" ");
    Api.getDeathsCount(_getName).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.deathcountListesi =
            list.map((e) => DeathCount.fromJson(e)).toList();
        loading = true;
      });
    });
  }
}
