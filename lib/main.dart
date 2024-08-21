import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morties/common/app_colors.dart';
import 'package:flutter_rick_and_morties/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_rick_and_morties/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_rick_and_morties/feature/presentation/pages/person_screen.dart';
import 'package:flutter_rick_and_morties/locator_services.dart' as di;

import 'locator_services.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(
            create: (context) => sl<PersonListCubit>()..loadPerson(),
          ),
          BlocProvider<PersonSearchBloc>(
            create: (context) => sl<PersonSearchBloc>(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            //backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ));
  }
}
