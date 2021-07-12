import 'package:flutter/material.dart';
import 'starwarrepo.dart';

class StarWarpeople extends StatefulWidget {
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<StarWarpeople> {
  @override
  void initState() {
    super.initState();
    StarwarsRepo().fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "StarWar-API",
        )),
        body: ListView.builder(itemBuilder: (BuildContext context, int index) {
         return 
        }));
  }
}
