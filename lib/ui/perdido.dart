import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class Perdido extends StatefulWidget {
  @override
  _PerdidoState createState() => _PerdidoState();
}

class _PerdidoState extends State<Perdido> {

  Future<Map> _getPets() async {
    http.Response response;
    response = await http.get("http://www.olimpiodev.kinghost.net/pets/api/perdidos?access_token=meu_token&region=todos&category=todos&offset=1");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getPets(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container(
                width: 200.0,
                height: 200.0,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 5.0,
                ),
              );
            default:
              if (snapshot.hasError) return Container();
              else return _createPetsGrid(context, snapshot);
          }
        }
    );
  }

  Widget _createPetsGrid(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        itemCount: snapshot.data["data"].length,
        itemBuilder: (context, index) {
          return GestureDetector(
              child: FadeInImage.memoryNetwork(
                image: snapshot.data["data"][index]["url"],
                height: 300.0,
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
              )
          );
        }
    );
  }
}
