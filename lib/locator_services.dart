import 'package:flutter_rick_and_morties/core/platform/network_info.dart';
import 'package:flutter_rick_and_morties/feature/data/datasources/person_local_data_sources.dart';
import 'package:flutter_rick_and_morties/feature/data/datasources/person_remote_data_sources.dart';
import 'package:flutter_rick_and_morties/feature/data/repositories/person_repository_impl.dart';
import 'package:flutter_rick_and_morties/feature/domain/repositories/person_repository.dart';
import 'package:flutter_rick_and_morties/feature/domain/usecases/get_all_persons.dart';
import 'package:flutter_rick_and_morties/feature/domain/usecases/search_person.dart';
import 'package:flutter_rick_and_morties/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_rick_and_morties/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
//
//Bloc / cubit
  sl.registerFactory(
    () => PersonListCubit(
      getAllPersons: sl(),
    ),
  );
  sl.registerFactory(
    () => PersonSearchBloc(
      searchPerson: sl(),
    ),
  );

//useCases
  sl.registerLazySingleton(
    () => GetAllPersons(
      sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SearchPerson(
      sl(),
    ),
  );

//repository
  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PersonRemoteDataSources>(
    () => PersonRemoteDataSourcesImpl(
      client: http.Client(),
    ),
  );

  sl.registerLazySingleton<PersonLocalDataSources>(
    () => PersonLocalDataSourcesImpl(
      sharedPreferences: sl(),
    ),
  );

  await _initSharedPref();

//core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

//external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
    () async => sharedPreferences,
  );
  sl.registerLazySingleton(
    () => http.Client(),
  );
  sl.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}

Future<void> _initSharedPref() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPref);
}
