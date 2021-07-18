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
       appBar: AppBar(title: Text("StarsWars API"),
       backgroundColor: Color(0xFFEFDBB2),),
      body: 
      getBody(),
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
              child: Text("Error While Loading Data. Please Try Again"), // return this text to change the upper state
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
                    child: Text("Error while loading more Data ,Please tap to try agin"),
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
          print('ID : ' + peoples.id + ' Name : '+ peoples.name + ' Haircolor : ' + peoples.haircolor) ;
           Color eyecolor , haircolor  ;
           Color bgcolor = Color(0xFFFFFFFF) ; // test console 
           var heightmetre  , weightkg;
           double fontsize = 16 ;
           var eyecolorset = peoples.eyecolor.split(',') ;
           var eyecolorfirst = eyecolorset[0].toString() ;
           var haircolorset = peoples.haircolor.split(',') ;
           var haircolorfirst = haircolorset[0].toString() ;
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
           switch (eyecolorfirst) {
             case 'red' : 
                eyecolor = Color(0xFFFF0000) ;
               break;
             case 'blue' : 
                eyecolor = Color(0xFF0000FF) ;
               break;
             case 'yellow' : 
                eyecolor = Color(0xFFFFFF00) ;
               break;
             case 'brown' : 
                eyecolor = Color(0xFFA52A2A) ;
               break;
             case 'blue-gray' : 
                eyecolor = Color(0xFF6699CC) ;
               break;  
             case 'black' : 
                eyecolor = Color(0xFF000000) ;
               break;  
             case 'hazel' : 
                eyecolor = Color(0xFFC9C789) ;
               break;
             case 'orange' : 
                eyecolor = Color(0xFFFFA500) ;
               break;  
             case 'pink' : 
                eyecolor = Color(0xFFFFC0CB) ;
               break;  
             case 'gold' : 
                eyecolor = Color(0xFFFFD700) ;
               break;     
             case 'white' : 
                eyecolor = Color(0xFFD8D8D8) ;
               break; 
            case 'green' : 
                eyecolor = Color(0xFF00FF00) ;
               break;     
             default:
                eyecolor = Color(0xFFee82ee) ;
           }

           switch (haircolorfirst) {
             case 'blond' : 
                haircolor = Color(0xFFF1CC8F) ;
               break;
             case 'black' : 
                haircolor = Color(0xFF000000) ;
               break;
             case 'auburn' : 
                haircolor = Color(0xFF71231D) ;
               break;
             case 'brown' : 
                haircolor = Color(0xFFA52A2A) ;
               break;
             case 'white' : 
                haircolor = Color(0xFFD3D3D3) ;
               break;
              default :
              haircolor = Color(0xFFCD7F32) ;  
           }

           switch ((index+1)%10) {
             case 1 : 
                bgcolor = Color(0xFFE2F0CB) ;
               break;
             case 2 : 
                bgcolor = Color(0xFFFEC8D8) ;
               break;
             case 3 : 
                bgcolor = Color(0xFFD291BC) ;
               break;
             case 4 : 
                bgcolor = Color(0xFF957DAD) ;
               break;
             case 5 : 
                bgcolor = Color(0xFFE0BBE4) ;
               break;
             case 6 : 
                bgcolor = Color(0xFFFF9AA2) ;
               break;
             case 7 : 
                bgcolor = Color(0xFFFFB7B2) ;
               break;
             case 8 : 
                bgcolor = Color(0xFFFFDAC1) ;
               break;
             case 9 : 
                bgcolor = Color(0xFFB5EAD7) ;
               break;
             case 0 : 
                bgcolor = Color(0xFFC7CEEA) ;
               break;
              default :
              haircolor = Color(0xFFD3D3D3) ;  
           }
       
       
           if(numbirthyear == 'unknown') {
               numbirthyear = 'Unknown' ;
           }
           else {
             numbirthyear = numbirthyear + ' BBY' ;
           }
           print(haircolorfirst) ;
          return Card(
            color : bgcolor ,
            child: Row(
              children: <Widget>[
                Image.network(
                  'https://starwars-visualguide.com/assets/img/characters/${peoples.id}.jpg', // image bring from id
                  fit: BoxFit.fitWidth,
                  width: 160 ,
                  height: 160,
                ),
                Padding( // change style paddding
                  padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: Column(
                    children : [ 
                      Text(
                    'No.${peoples.id}' ,
                    
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontsize
                    ),
                  ),Align(
                    alignment: Alignment.center,
                   child : Text(
                    'Name : ${peoples.name}' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontsize,
                    ),
                  )),
                  Text(
                    'Height : $heightmetre' ,
                    textAlign: TextAlign.center,
                    style: TextStyle( 
                      fontWeight : FontWeight.bold,
                      fontSize: fontsize ,
                  )),
                   Text(
                    'Weight : $weightkg' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontsize,
                    ),
                  ),
                   Text(
                    'Hair Color : ${peoples.haircolor}' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontsize,
                      color: haircolor,
                    ),
                  ),
                   Text(
                    'Eye Color : ${peoples.eyecolor}' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontsize,
                      color: eyecolor,
                    ),
                  ),
                     Text(
                    'Birthyear : $numbirthyear' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontsize
              
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


