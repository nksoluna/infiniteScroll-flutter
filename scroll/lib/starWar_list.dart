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
  final int _defaultPhotosPerPageCount = 10; // Initialize variable
  List<People> _people = [];
  final int _nextPageThreshold = 5;
  
  @override
  void initState() {
    super.initState();
     _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;   // Set all in init state
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
        }, // Set state if its run property    
      );
    } catch (e) {
      setState(
        () {
          _loading = false;
          _error = true; // Setstate if error or exception
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
    if (_people.isEmpty) { // for checking if _people  is empty data loading will Stop
      if (_loading) { // if loading still True , It still use widget
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(), // loading with circular loader
        ));
      } else if (_error) { // if error = true
        return Center(
          child: InkWell(
            onTap: () => setState(
              () {
                _loading = true; //change loading to true and trying load same page
                _error = false; //change error to false
                fetchpeople(); // tap to set new State 
              },
            ),
            child: Padding( // if cannot loading
              padding: const EdgeInsets.all(16),
              child: Text("Error While Loading Image. Please Try Again"), // return this text to change the upper state
            ),
          ),
        );
      }
    } else { // if error = false
      return ListView.builder(
        itemCount: _people.length + (_hasMore ? 1 : 0), // itemCount = amount of people and if _hasmore = true this count will stop in last element
        itemBuilder: (context, index) { 
          if (index == _people.length - _nextPageThreshold) { // if people.length has more     than nextpagethreshold
            fetchpeople(); //fetching people
          }
          if (index == _people.length) {
            if (_error) { // same as error
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
                  child: CircularProgressIndicator(), // Primary Swatch
                ),
              );
            }
          }
          final People peoples = _people[index];
          print('ID : ' + peoples.id + ' Name : '+ peoples.name + ' Eyecolor : ' + peoples.eyecolor) ;
           Color eyecolor  ; // test console 
           var heightmetre  , weightkg;
           var birthyear = peoples.birthyear.split('BBY'); 
           var numbirthyear = birthyear[0] ;
           if (peoples.height == 'unknown') {
              heightmetre = 'Unknown' ; 
           }
           else {
             heightmetre = (double.parse(peoples.height)/100).toString() + ' m' ;
           }

           if (peoples.weight != 'unknown') {
             weightkg = peoples.weight + ' kg' ;
           }
           else {
             weightkg = 'Unknown' ;
           }
           if(peoples.eyecolor == 'n/a' || peoples.eyecolor == 'none') {
             eyecolor = Colors.black ;
           }
           else {
             eyecolor = Colors.redAccent ;
           }
       
           if(numbirthyear == 'unknown') {
               numbirthyear = 'Unknown' ;
           }
           else {
             numbirthyear = numbirthyear + ' BBY' ;
           }
          return Card(
            child: Column(
              children: <Widget>[
                Image.network(
                  'https://starwars-visualguide.com/assets/img/characters/${peoples.id}.jpg', // image bring from id
                  fit: BoxFit.fitWidth,
                  width: 160 ,
                  height: 160,
                ),
                Padding( // change style paddding
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children : [ 
                      Text(
                    'No.${peoples.id}' ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                   Text(
                    'Name : ${peoples.name}' ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Height : $heightmetre' ,
                    style: TextStyle( 
                      fontWeight : FontWeight.bold,
                      fontSize: 16 ,
                  )),
                   Text(
                    'Weight : $weightkg' ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                   Text(
                    'Hair Color : ${peoples.haircolor}' ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.brown ,
                    ),
                  ),
                   Text(
                    'Eye Color : ${peoples.eyecolor}' ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: eyecolor,
                    ),
                  ),
                     Text(
                    'Birthyear : $numbirthyear' ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
              
                    ),
                  ),
                    ]),
                )],
            ),
          );
          },
      );
    }
    return Container();
  }
}


