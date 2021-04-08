import 'package:flutter/material.dart';

Widget cardOlusturucu(String leading, String title, BuildContext context) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
    child: ListTile(
      leading: Text(
        leading,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      ),
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 25.0),
      ),
    ),
  );
}
