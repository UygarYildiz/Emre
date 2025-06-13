import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String id,
    required String name,
    @JsonKey(name: 'alternate_names') List<String>? alternateNames,
    String? species,
    String? gender,
    String? house,
    @JsonKey(name: 'dateOfBirth') String? dateOfBirth,
    @JsonKey(name: 'yearOfBirth') int? yearOfBirth,
    bool? wizard,
    String? ancestry,
    @JsonKey(name: 'eyeColour') String? eyeColour,
    @JsonKey(name: 'hairColour') String? hairColour,
    Wand? wand,
    String? patronus,
    @JsonKey(name: 'hogwartsStudent') bool? hogwartsStudent,
    @JsonKey(name: 'hogwartsStaff') bool? hogwartsStaff,
    String? actor,
    @JsonKey(name: 'alternate_actors') List<String>? alternateActors,
    bool? alive,
    String? image,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

@freezed
class Wand with _$Wand {
  const factory Wand({
    String? wood,
    String? core,
    double? length,
  }) = _Wand;

  factory Wand.fromJson(Map<String, dynamic> json) => _$WandFromJson(json);
} 