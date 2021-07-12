import 'package:flutter/material.dart';
import 'starwarrepo.dart';

class StarWarpeople extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<StarWarpeople> {
  var _datafromAPI = StarwarsRepo();
  @override
  void initState() {
    super.initState();
    _datafromAPI.fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
        appBar: AppBar(
            title: Text(
      "StarWar-API",
    )));
  }
}
