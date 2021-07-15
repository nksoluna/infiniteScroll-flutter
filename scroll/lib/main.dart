import 'package:flutter/material.dart';
import 'starWar_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "StarWars-API",
      home: StarWarpeople(),
      theme: ThemeData(primarySwatch: Colors.orange),
    );
  }
}
