import 'package:flutter/material.dart';

import 'package:flutter_rick_and_morties/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_and_morties/feature/presentation/pages/person_detail_screen.dart';
import 'package:flutter_rick_and_morties/feature/presentation/widgets/person_cache_image.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;
  const SearchResult({super.key, required this.personResult});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailPage(person: personResult),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Container(
                child: PersonCacheImage(
                    imageUrl: personResult.image as String,
                    height: double.infinity,
                    width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.name as String,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.location!.name as String,
                style: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
