import 'dart:convert';

import 'package:flutter_rick_and_morties/core/error/exception.dart';
import 'package:flutter_rick_and_morties/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class PersonRemoteDataSources {
  Future<List<PersonModel>> getAllPerson(int page);
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourcesImpl implements PersonRemoteDataSources {
  final http.Client client;

  PersonRemoteDataSourcesImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPerson(int page) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$page');

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
