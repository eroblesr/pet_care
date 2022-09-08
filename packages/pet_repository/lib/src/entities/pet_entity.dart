import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class PetEntity extends Equatable {
  const PetEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.photoUrl,
  });

  final String id;
  final String? name;
  final String? location;
  final String? photoUrl;

  @override
  List<Object?> get props => [id, name, location, photoUrl];

  static PetEntity fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final petData = snapshot.data()!;
    return PetEntity(
      id: snapshot.id,
      name: petData['name'] as String,
      location: petData['location'] as String,
      photoUrl: petData['photoUrl'] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'name': name ?? '',
      'location': location ?? '',
      'photoUrl': photoUrl ?? '',
    };
  }
}
