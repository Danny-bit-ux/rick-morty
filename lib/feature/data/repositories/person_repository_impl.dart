import 'package:flutter_rick_and_morties/core/error/exception.dart';
import 'package:flutter_rick_and_morties/core/platform/network_info.dart';
import 'package:flutter_rick_and_morties/feature/data/datasources/person_local_data_sources.dart';
import 'package:flutter_rick_and_morties/feature/data/datasources/person_remote_data_sources.dart';
import 'package:flutter_rick_and_morties/feature/data/models/person_model.dart';
import 'package:flutter_rick_and_morties/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_and_morties/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_rick_and_morties/feature/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSources remoteDataSource;
  final PersonLocalDataSources localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return remoteDataSource.getAllPerson(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remoteDataSource.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
