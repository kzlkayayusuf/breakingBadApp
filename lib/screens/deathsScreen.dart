import 'dart:convert';

import 'package:breakingbad/apis/api.dart';
import 'package:breakingbad/models/deaths.dart';
import 'package:breakingbad/screens/deathCountScreen.dart';
import 'package:flutter/material.dart';

import 'deathAyrintiEkrani.dart';

class Deaths extends StatefulWidget {
  @override
  _DeathsState createState() => _DeathsState();
}

class _DeathsState extends State<Deaths> {
  List<Death> deathListesi = [];
  void deathGetir() {
    Api.getDeaths().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.deathListesi = list.map((e) => Death.fromJson(e)).toList();
      });
    });
  }

  final _nameController = TextEditingController();
  String nameTutucu;

  @override
  void initState() {
    super.initState();
    deathGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breaking Bad'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _getName(context);
            },
            tooltip: "Ara",
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DeathAyrinti(
                    name: ["rastgele", "ölüm"],
                  ),
                ),
              );
            },
            icon: Icon(Icons.autorenew),
            label: Text('Rastgele'),
            style: TextButton.styleFrom(primary: Colors.black),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).backgroundColor,
              Theme.of(context).scaffoldBackgroundColor
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: ListView.builder(
          itemCount: deathListesi.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DeathAyrinti(
                      name: deathListesi[index].death.split(" "),
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  deathListesi[index].death + "'s death",
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 20.0,
                  ),
                ),
                leading: CircleAvatar(
                  child: Text(deathListesi[index].id.toString()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _getName(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _nameController,
                      decoration:
                          InputDecoration(labelText: "İsim-Soyisim Giriniz: "),
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
                        _getDeathsWithName();
                        nameTutucu = "";
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: Text(
                        'Ölüm sayısı getir',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DeathCountScreen()));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _getDeathsWithName() {
    List _getName;
    _getName = nameTutucu.split(" ");
    Api.getDeathsWithName(_getName).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.deathListesi = list.map((e) => Death.fromJson(e)).toList();
      });
    });
  }
}
