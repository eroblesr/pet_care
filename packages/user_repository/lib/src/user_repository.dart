import 'package:built_collection/built_collection.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/user_repository.dart';

import 'models/models.dart';

abstract class UserRepository {
  Future<void> addUser(UserEntity userEntity);
  Stream<BuiltList<User>> users();
  Future<void> updateUser(User user);
  Future<void> deleteItem(String userId);
}
