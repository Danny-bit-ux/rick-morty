import 'package:flutter_rick_and_morties/feature/domain/entities/person_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({name, url}) : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
