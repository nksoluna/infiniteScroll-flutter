import 'package:flutter/material.dart';
import 'starwarrepo.dart';

class StarWarpeople extends StatefulWidget {

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<StarWarpeople> {
 bool _hasMore = true;
  int _pageNumber =  1;
  bool _error = false;
  bool _loading = true;
  final int _defaultPhotosPerPageCount = 10;
  List<People> _people = [];
  final int _nextPageThreshold = 5;
  
  @override
  void initState() {
    super.initState();
     _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;
    _people = [] ;
    fetchpeople() ;
  }
  Future<void> fetchpeople() async {
  try {
      List<People> repolist = await StarwarsRepo().fetchPeople(page: _pageNumber) ;
      setState(
        () {
          _hasMore = repolist.length == _defaultPhotosPerPageCount;
          _loading = false;
          _pageNumber = _pageNumber + 1;
          _people.addAll(repolist);
        },
      );
    } catch (e) {
      setState(
        () {
          _loading = false;
          _error = true;
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("StarsWars API")),
      body: getBody(),
      );
  }
   Widget getBody() {
    if (_people.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(
          child: InkWell(
            onTap: () => setState(
              () {
                _loading = true;
                _error = false;
                fetchpeople();
              },
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text("Error While Loading Image. Please Try Again"),
            ),
          ),
        );
      }
    } else {
      return ListView.builder(
        itemCount: _people.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _people.length - _nextPageThreshold) {
            fetchpeople();
          }
          if (index == _people.length) {
            if (_error) {
              return Center(
                child: InkWell(
                  onTap: () => setState(
                    () {
                      _loading = true;
                      _error = false;
                      fetchpeople();
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
          final People peoples = _people[index];
          print('ID : ' + peoples.id + ' ' + peoples.name + ' Height : ' + peoples.height + ' Weight : ' + peoples.weight);
          return Card(
            child: Column(
              children: <Widget>[
                Image.network(
                  'https://starwars-visualguide.com/assets/img/characters/${peoples.id}.jpg',
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: 160,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    peoples.name + ' ' + peoples.id ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return Container();
  }
}


