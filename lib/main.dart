import 'package:flutter/material.dart';
import 'package:pets_app/ui/perdido.dart';
import 'package:pets_app/ui/adocao.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Perdidos"),
                Tab(text: "Adoção"),
              ],
            ),
            title: Text('CadeMeuPet'),
          ),
          body: TabBarView(
            children: [
              Perdido(),
              Adocao(),
            ],
          ),
        ),
      ),
    );
  }
}