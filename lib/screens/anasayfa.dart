import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:http/http.dart';
import 'package:flutter_html/flutter_html.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String _htmlVeri = '';

  @override
  void initState() {
    super.initState();
    _istek();
  }

  Future _istek() async {
    _htmlVeri = '';
    setState(() {});
    await get(Uri.parse('https://tr.wikipedia.org/wiki/Breaking_Bad'))
        .then((gelenVeri) {
      _htmlVeri = gelenVeri.body
          .replaceAll('\n', '')
          .replaceAll('\t', '')
          .replaceAll('  ', '');

      RegExp arama = RegExp(
          '<p>(.*?)<div id="toc" class="toc" role="navigation" aria-labelledby="mw-toc-heading">');
      Match eslesen = arama.firstMatch(_htmlVeri);
      _htmlVeri = eslesen.group(1);
      debugPrint(_htmlVeri);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breaking Bad'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _istek,
          ),
        ],
      ),
      body: Center(
        child: _htmlVeri.length > 0
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                    data: _htmlVeri,
                    style: {
                      "p": Style(fontSize: FontSize.xLarge),
                      "a": Style(fontSize: FontSize.xLarge),
                      "i": Style(fontSize: FontSize.xLarge),
                    },
                  ),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
