import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morties/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_and_morties/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_rick_and_morties/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:flutter_rick_and_morties/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_rick_and_morties/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search');

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer'
        'Beth',
    'Jerry'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_outlined),
      tooltip: 'Back',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
      ..add(SearchPersons(query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (context, state) {
      if (state is PersonSearchLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PersonSearchLoaded) {
        final person = state.persons;
        if (person.isEmpty) {
          return _showErrorText('No Result');
        }
        return Container(
          child: ListView.builder(
            itemCount: person.isNotEmpty ? person.length : 0,
            itemBuilder: (context, int index) {
              PersonEntity result = person[index];
              return SearchResult(
                personResult: result,
              );
            },
          ),
        );
      } else if (state is PersonSearchError) {
        return _showErrorText(state.message);
      } else {
        return Center(
          child: Icon(Icons.now_wallpaper),
        );
      }
    });
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      return Container();
    }
    return ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Text(
            _suggestions[index],
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: _suggestions.length);
  }
}
