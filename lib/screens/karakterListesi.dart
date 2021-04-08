import 'dart:convert';

import 'package:breakingbad/apis/api.dart';
import 'package:breakingbad/models/karakter.dart';
import 'package:breakingbad/screens/karakterAyrintiEkrani.dart';
import 'package:flutter/material.dart';

enum OrderCategory { orderBb, orderBcs }

class Karakterler extends StatefulWidget {
  @override
  _KarakterlerState createState() => _KarakterlerState();
}

class _KarakterlerState extends State<Karakterler> {
  List<Karakter> karakterListesi = [];
  void karakterlerGetir() {
    Api.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.karakterListesi = list.map((e) => Karakter.fromJson(e)).toList();
      });
    });
  }

  final _limitController = TextEditingController();
  final _offsetController = TextEditingController();
  final _nameController = TextEditingController();
  String limit, offset, nameTutucu;
  bool al = false;

  @override
  void initState() {
    super.initState();
    karakterlerGetir();
  }

  @override
  Widget build(BuildContext context) {
    _limitController.text = limit;
    _offsetController.text = offset;
    _nameController.text = nameTutucu;
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _getLimit(context);

              al = false;
            },
            tooltip: "Ara",
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Ayrinti(
                    id: -1,
                  ),
                ),
              );
            },
            icon: Icon(Icons.autorenew),
            tooltip: ('Rastgele'),
            color: Colors.black,
          ),
          PopupMenuButton<OrderCategory>(
            itemBuilder: (context) => <PopupMenuEntry<OrderCategory>>[
              PopupMenuItem<OrderCategory>(
                child: Text('Breaking Bad'),
                value: OrderCategory.orderBb,
              ),
              PopupMenuItem<OrderCategory>(
                child: Text('Better Call Saul'),
                value: OrderCategory.orderBcs,
              ),
            ],
            onSelected: _selectSeries,
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
          itemCount: karakterListesi.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Ayrinti(
                      id: karakterListesi[index].id,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  karakterListesi[index].name,
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 20.0,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(karakterListesi[index].img),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _selectSeries(OrderCategory value) {
    switch (value) {
      case OrderCategory.orderBb:
        badKarakterlerGetir();
        break;
      case OrderCategory.orderBcs:
        callKaraktelerGetir();
        break;
    }
    setState(() {});
  }

  void badKarakterlerGetir() {
    List bb = ["Breaking", "Bad"];
    Api.getCharactersCategory(bb).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.karakterListesi = list.map((e) => Karakter.fromJson(e)).toList();
        print("çalıştı");
      });
    });
  }

  void callKaraktelerGetir() {
    List bcs = ["Better", "Call", "Saul"];
    Api.getCharactersCategory(bcs).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.karakterListesi = list.map((e) => Karakter.fromJson(e)).toList();
      });
    });
  }

  void _getLimit(BuildContext context) {
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
                      controller: _limitController,
                      decoration: InputDecoration(labelText: "Limit Giriniz: "),
                      keyboardType: TextInputType.number,
                      onChanged: (sayi) {
                        limit = sayi;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _offsetController,
                      decoration:
                          InputDecoration(labelText: "Offset Giriniz: "),
                      keyboardType: TextInputType.number,
                      onChanged: (sayi) {
                        offset = sayi;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: "İsim veya İsim-Soyisim Giriniz: "),
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
                        al = true;
                        if (_limitController.text.isNotEmpty) {
                          _getCharactersWithLimit();
                          _limitController.text = "";
                          _offsetController.text = "";
                          Navigator.pop(context);
                        } else if (_nameController.text.isNotEmpty) {
                          _getCharactersWithName();
                          _nameController.text = "";
                          Navigator.pop(context);
                        }
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

  void _getCharactersWithLimit() {
    if (al == true) {
      Api.getCharactersWithLimit(int.parse(limit), int.parse(offset))
          .then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          this.karakterListesi = list.map((e) => Karakter.fromJson(e)).toList();
        });
      });
    }
  }

  void _getCharactersWithName() {
    if (al == true) {
      List _getName;
      _getName = nameTutucu.split(" ");
      Api.getCharactersWithName(_getName).then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          this.karakterListesi = list.map((e) => Karakter.fromJson(e)).toList();
        });
      });
    }
  }
}
