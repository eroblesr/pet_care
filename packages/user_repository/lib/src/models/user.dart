import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/user_repository.dart';

@immutable
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.location,
    required this.photoUrl,
  });

  final String id;
  final String name;
  final String location;
  final String photoUrl;

  @override
  List<Object> get props => [id, name, location, photoUrl];

  static const User empty = User(id: '', name: '', location: '', photoUrl: '');

  bool get isNotEmpty => id.isNotEmpty;

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      location: location,
      photoUrl: photoUrl,
    );
  }

  static User fromEntity(UserEntity userEntity) {
    return User(
      id: userEntity.id,
      name: userEntity.name ?? '',
      location: userEntity.location ?? '',
      photoUrl: userEntity.photoUrl ?? '',
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? location,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
