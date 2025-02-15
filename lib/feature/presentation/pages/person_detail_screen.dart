import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morties/common/app_colors.dart';
import 'package:flutter_rick_and_morties/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_and_morties/feature/presentation/widgets/person_cache_image.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;
  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              person.name as String,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              child: PersonCacheImage(
                height: 260,
                imageUrl: person.image as String,
                width: 260,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  person.status as String,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            if (person.type!.isNotEmpty)
              ...buildText('Type', person.type as String),
            ...buildText('Gender:', person.gender as String),
            ...buildText(
              'Number of episodes: ',
              person.episode!.length.toString(),
            ),
            ...buildText('Species:', person.species as String),
            ...buildText(
                'Last know location:', person.location!.name as String),
            ...buildText('Origin:', person.origin!.name as String),
            ...buildText(
              'Was created:',
              person.created.toString(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: const TextStyle(
          color: AppColors.greyColor,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }
}
