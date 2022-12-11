import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UserEntity extends Equatable {
  const UserEntity({
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

  static UserEntity fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final userData = snapshot.data()!;
    return UserEntity(
      id: snapshot.id,
      name: userData['name'] as String,
      location: userData['location'] as String,
      photoUrl: userData['photoUrl'] as String,
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
