import 'dart:convert';

import 'package:flutter_rick_and_morties/core/error/exception.dart';
import 'package:flutter_rick_and_morties/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSources {
  /// Gets the cached [List<PersonModel>] which was gotten the last time
  /// the user had aan internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.

  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourcesImpl implements PersonLocalDataSources {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);

    return Future.value(jsonPersonsList);
  }
}
