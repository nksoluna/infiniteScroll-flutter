import 'package:dio/dio.dart';

class People {
  final String id ;
  final String name;
  final String weight;
  final String height;
  final String haircolor;
  final String eyecolor;
  final String birthyear;
  final String gender;

  People(this.id ,this.name, this.weight, this.height, this.haircolor, this.eyecolor,
      this.birthyear, this.gender);

  factory People.fromJson(dynamic json) {
    var id = 'https://swapi.dev/api/people/'.split('/').last.split('/').first ;
    return People(
      id ,
        json['name'],
        json['weight'],
        json['height'],
        json['hair_color'],
        json['eye_color'],
        json['birth_year'],
        json['gender']);
  }
}

class StarwarsRepo {
  Future<List<People>> fetchPeople({int page = 1}) async {
    var response = await Dio().get('https://swapi.dev/api/people?page=$page');
    List<dynamic> result = response.data['results'];
    return result.map((e) => People.fromJson(e)).toList();
  }
}
