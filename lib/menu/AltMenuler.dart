import 'package:breakingbad/screens/anasayfa.dart';
import 'package:breakingbad/screens/deathsScreen.dart';
import 'package:breakingbad/screens/episodesScreen.dart';
import 'package:breakingbad/screens/karakterListesi.dart';
import 'package:breakingbad/screens/quotesScreen.dart';
import 'package:flutter/material.dart';

class AltMenuler extends StatefulWidget {
  @override
  _AltMenulerState createState() => _AltMenulerState();
}

class _AltMenulerState extends State<AltMenuler> {
  int secilmisDeger = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: secilmisDeger,
      onTap: (index) {
        setState(() {
          secilmisDeger = index;
          if (secilmisDeger == 0) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Anasayfa()));
          }
          if (secilmisDeger == 1) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Karakterler()));
          }
          if (secilmisDeger == 2) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Episodes()));
          }
          if (secilmisDeger == 3) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Quotes()));
          }
          if (secilmisDeger == 4) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Deaths()));
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Anasayfa",
          backgroundColor: Colors.yellow,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_walk_rounded),
          label: "Karakterler",
          backgroundColor: Colors.yellow,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.slow_motion_video_rounded),
          label: "Bölümler",
          backgroundColor: Colors.yellow,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded),
          label: "Sözler",
          backgroundColor: Colors.yellow,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.desktop_access_disabled_sharp),
          label: "Ölüler",
          backgroundColor: Colors.yellow,
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
