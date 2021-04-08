import 'dart:convert';

import 'package:breakingbad/apis/api.dart';
import 'package:breakingbad/models/episodes.dart';
import 'package:breakingbad/screens/episodeAyrintiEkrani.dart';
import 'package:flutter/material.dart';

enum OrderCategory { orderBb, orderBcs }

class Episodes extends StatefulWidget {
  @override
  _EpisodesState createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  List<Episode> episodeListesi = [];
  void episodeGetir() {
    Api.getEpisodes().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.episodeListesi = list.map((e) => Episode.fromJson(e)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    episodeGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breaking Bad'),
        actions: [
          // TextButton.icon(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (_) => EpisodeAyrinti(
          //           id: -1,
          //         ),
          //       ),
          //     );
          //   },
          //   icon: Icon(Icons.autorenew),
          //   label: Text('Rastgele'),
          //   style: TextButton.styleFrom(primary: Colors.black),
          // ),
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
          itemCount: episodeListesi.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EpisodeAyrinti(
                      id: episodeListesi[index].id,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  episodeListesi[index].title,
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 20.0,
                  ),
                ),
                leading: CircleAvatar(
                  child: Text(episodeListesi[index].season +
                      "," +
                      episodeListesi[index].episode),
                ),
                trailing: Text(episodeListesi[index].series),
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
        badEpisodesGetir();
        break;
      case OrderCategory.orderBcs:
        callEpisodesGetir();
        break;
    }
    setState(() {});
  }

  void badEpisodesGetir() {
    List bb = ["Breaking", "Bad"];
    Api.getEpisodesCategory(bb).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.episodeListesi = list.map((e) => Episode.fromJson(e)).toList();
        print("çalıştı");
      });
    });
  }

  void callEpisodesGetir() {
    List bcs = ["Better", "Call", "Saul"];
    Api.getEpisodesCategory(bcs).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.episodeListesi = list.map((e) => Episode.fromJson(e)).toList();
      });
    });
  }
}
