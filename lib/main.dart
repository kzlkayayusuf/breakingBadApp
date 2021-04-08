import 'package:flutter/material.dart';

import 'menu/AltMenuler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breaking Bad App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xff67e6dc),
        accentColor: Color(0xffeb4d4b),
        secondaryHeaderColor: Color(0xff222f3e),
        backgroundColor: Color(0xfffc5c650),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.movie_filter_rounded),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Icon(Icons.featured_video_rounded),
            ),
          ],
          title: Center(
            child: Image.network(
              "https://famfonts.com/wp-content/uploads/breaking-bad-wide.png",
              width: 150,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 20,
        ),
        body: Column(
          children: [],
        ),
        bottomNavigationBar: AltMenuler(),
      ),
    );
  }
}
