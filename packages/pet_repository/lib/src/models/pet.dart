import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pet_repository/pet_repository.dart';

@immutable
class Pet extends Equatable {
  const Pet({
    required this.id,
    required this.name,
    required this.location,
    required this.photoUrl,
  });

  final String id;
  final String name;
  final String location;
  final String photoUrl;

  static const Pet empty = Pet(id: '', name: '', location: '', photoUrl: '');

  @override
  List<Object> get props => [id, name, location, photoUrl];

  PetEntity toEntity() {
    return PetEntity(
      id: id,
      name: name,
      location: location,
      photoUrl: photoUrl,
    );
  }

  static Pet fromEntity(PetEntity petEntity) {
    return Pet(
      id: petEntity.id,
      name: petEntity.name ?? '',
      location: petEntity.location ?? '',
      photoUrl: petEntity.photoUrl ?? '',
    );
  }
}
