import 'package:favorites_advanced_base/src/utils/enums.dart';
import 'package:favorites_advanced_base/src/utils/puppy_data_conversion.dart';

import 'entity.dart';

class Puppy /*extends Equatable*/ implements Entity {
  final String id;
  final String name;
  final String breedCharacteristics;
  final String asset;
  final BreedType breedType;
  final Gender gender;

  bool isFavorite;

  // Properties that should simulate remote fetching of entity data
  final String? displayName;
  final String? displayCharacteristics;

  Puppy({
    required this.id,
    required this.name,
    required this.asset,
    this.displayName,
    this.displayCharacteristics,
    this.isFavorite = false,
    this.breedCharacteristics =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ',
    this.breedType = BreedType.Mixed,
    this.gender = Gender.Male,
  });

  /// Check whether the current entity has all needed extra details.
  bool hasExtraDetails() =>
      displayCharacteristics != null && displayName != null;

  bool hasFullExtraDetails() => false;

  @override
  bool operator ==(Object other) {
    if (other is Puppy) {
      // return false;
      return id == other.id &&
          name == other.name &&
          asset == other.asset &&
          displayName == other.displayName &&
          displayCharacteristics == other.displayCharacteristics &&
          isFavorite == other.isFavorite &&
          breedCharacteristics == other.breedCharacteristics &&
          breedType == other.breedType &&
          gender == other.gender
          // hashCode == other.hashCode
      ;
    }

    return false;
  }

  Puppy copyWith({
    String? id,
    String? name,
    String? breedCharacteristics,
    Gender? gender,
    BreedType? breedType,
    bool? isFavorite,
    String? displayName,
    String? displayCharacteristics,
    String? asset,
  }) =>
      Puppy(
        id: id ?? this.id,
        name: name ?? this.name,
        breedCharacteristics: breedCharacteristics ?? this.breedCharacteristics,
        asset: asset ?? this.asset,
        isFavorite: isFavorite ?? this.isFavorite,
        gender: gender ?? this.gender,
        breedType: breedType ?? this.breedType,
        displayName: displayName ?? this.displayName,
        displayCharacteristics:
            displayCharacteristics ?? this.displayCharacteristics,
      );

  Puppy copyWithPuppy(Puppy puppy) => Puppy(
        id: puppy.id,
        name: puppy.name,
        breedCharacteristics: puppy.breedCharacteristics,
        asset: puppy.asset,
        isFavorite: puppy.isFavorite,
        gender: puppy.gender,
        breedType: puppy.breedType,
        displayName: puppy.displayName ?? displayName,
        displayCharacteristics:
            puppy.displayCharacteristics ?? displayCharacteristics,
      );

  @override
  T copyWithEntity<T extends Entity>(T entity) =>
      copyWithPuppy(entity as Puppy) as T;

  String get genderAsString => PuppyDataConversion.getGenderString(gender);

  String? get breedTypeAsString =>
      PuppyDataConversion.getBreedTypeString(breedType);

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Puppy &&
  //         runtimeType == other.runtimeType &&
  //         id == other.id &&
  //         name == other.name &&
  //         breedCharacteristics == other.breedCharacteristics &&
  //         asset == other.asset &&
  //         breedType == other.breedType &&
  //         gender == other.gender &&
  //         isFavorite == other.isFavorite &&
  //         displayName == other.displayName &&
  //         displayCharacteristics == other.displayCharacteristics;

  // @override
  // int get hashCode => super.hashCode

  @override
  String toString() => '{$id, $name, $asset, $breedType, $isFavorite,'
      '${displayName == null ? "no displayName" : displayName}'
      '${displayCharacteristics == null ? "no displayBreedCharacteristics" : ""} }';

  // @override
  // List<Object?> get props => [id,name,breedCharacteristics,asset,breedType,
  // gender,isFavorite,displayName,displayCharacteristics];
}
