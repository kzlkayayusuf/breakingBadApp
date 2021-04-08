import 'dart:convert';

import 'package:breakingbad/apis/api.dart';
import 'package:breakingbad/models/quotes.dart';
import 'package:breakingbad/screens/quoteAyrintiEkrani.dart';
import 'package:flutter/material.dart';

enum OrderCategory { orderBb, orderBcs }

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  List<Quote> quoteListesi = [];
  void quoteGetir() {
    Api.getQuotes().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.quoteListesi = list.map((e) => Quote.fromJson(e)).toList();
      });
    });
  }

  final _nameController = TextEditingController();
  final _nameController1 = TextEditingController();
  String nameTutucu;
  bool al = false;

  @override
  void initState() {
    super.initState();
    quoteGetir();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = nameTutucu;
    _nameController1.text = nameTutucu;
    return Scaffold(
      appBar: AppBar(
        title: Text('Breaking Bad'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _getName(context);

              al = false;
            },
            tooltip: "Ara",
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuoteAyrinti(
                    id: -1,
                  ),
                ),
              );
            },
            icon: Icon(Icons.autorenew),
            label: Text('Rastgele'),
            style: TextButton.styleFrom(primary: Colors.black),
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
          itemCount: quoteListesi.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuoteAyrinti(
                      id: quoteListesi[index].id,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  quoteListesi[index].author + "'s quote",
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 20.0,
                  ),
                ),
                leading: CircleAvatar(
                  child: Text(quoteListesi[index].id.toString()),
                ),
                trailing: Text(quoteListesi[index].series),
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
        badQuotesGetir();
        break;
      case OrderCategory.orderBcs:
        callQuotesGetir();
        break;
    }
    setState(() {});
  }

  void badQuotesGetir() {
    List bb = ["Breaking", "Bad"];
    Api.getQuotesCategory(bb).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.quoteListesi = list.map((e) => Quote.fromJson(e)).toList();
        print("çalıştı");
      });
    });
  }

  void callQuotesGetir() {
    List bcs = ["Better", "Call", "Saul"];
    Api.getQuotesCategory(bcs).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.quoteListesi = list.map((e) => Quote.fromJson(e)).toList();
      });
    });
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
                    child: TextField(
                      controller: _nameController1,
                      decoration: InputDecoration(
                          labelText: "(random)İsim-Soyisim Giriniz: "),
                      keyboardType: TextInputType.text,
                      onChanged: (name1) {
                        nameTutucu = name1;
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
                        if (_nameController.text.isNotEmpty) {
                          al = true;
                          _getQuotesWithName();

                          nameTutucu = "";
                          Navigator.pop(context);
                        } else if (_nameController1.text.isNotEmpty) {
                          al = false;
                          _getQuotesWithName();

                          nameTutucu = "";
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

  void _getQuotesWithName() {
    List _getName;
    _getName = nameTutucu.split(" ");
    Api.getQuotesWithName(_getName, al).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.quoteListesi = list.map((e) => Quote.fromJson(e)).toList();
      });
    });
  }
}
