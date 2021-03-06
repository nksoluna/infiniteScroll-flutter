import 'package:dio/dio.dart';

class People {
  final String name;
  final String gender;
  final String id ;
  final String height ;
  final String weight ;
  final String haircolor ;
  final String eyecolor ;
  final String birthyear ;

  People(this.id ,this.name,this.height ,this.weight ,this.haircolor,this.eyecolor  ,this.birthyear, this.gender);

  factory People.fromJson(dynamic json) {
    var id = json['url'].split('https://swapi.dev/api/people/').last.split('/').first ;
    return People(id ,json["name"],json["height"],json["mass"] ,json["hair_color"] ,json["eye_color"] ,json["birth_year"] ,json["gender"]);
  }
}
class StarwarsRepo {
Future<List<People>> fetchPeople({int page = 1}) async {
final response = await Dio().get(
          'https://swapi.dev/api/people?page=$page');
      List<dynamic> result = response.data['results'];
      return result.map((i) => People.fromJson(i)).toList();
}
}

void main(List<String> args) async {
  final repo = await StarwarsRepo().fetchPeople(page: 1) ;
 print(repo) ;
}