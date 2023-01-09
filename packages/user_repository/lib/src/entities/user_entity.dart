import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.photoUrl,
  });

  final String id;
  final String? name;
  final String? phoneNumber;
  final String? location;
  final String? photoUrl;

  @override
  List<Object?> get props => [id, name, phoneNumber, location, photoUrl];

  static UserEntity fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final userData = snapshot.data()!;
    return UserEntity(
      id: snapshot.id,
      name: userData['name'] as String,
      phoneNumber: userData['phoneNumber'] as String,
      location: userData['location'] as String,
      photoUrl: userData['photoUrl'] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'name': name ?? '',
      'phoneNumber': phoneNumber ?? '',
      'location': location ?? '',
      'photoUrl': photoUrl ?? '',
    };
  }
}
