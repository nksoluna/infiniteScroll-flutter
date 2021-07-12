import 'package:dio/dio.dart';

class People {
  final String name;
  final int weight;
  final int height;
  final String hair_color;
  final String eye_color;
  final String birth_year;
  final String gender;

  People(this.name, this.weight, this.height, this.hair_color, this.eye_color,
      this.birth_year, this.gender);

  factory People.fromJson(dynamic json) {
    return People(
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
