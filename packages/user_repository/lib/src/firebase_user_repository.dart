import 'package:built_collection/src/list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final userCollection = FirebaseFirestore.instance.collection('users');
  @override
  Future<void> addUser(UserEntity userEntity) {
    return userCollection.doc(userEntity.id).set(userEntity.toDocument());
  }

  @override
  Future<void> deleteItem(String userId) {
    return userCollection.doc(userId).delete();
  }

  @override
  Stream<BuiltList<User>> users() {
    return userCollection.snapshots().map((snapshot) => snapshot.docs
        .map(
          (doc) => User.fromEntity(UserEntity.fromSnapshot(doc)),
        )
        .toBuiltList());
  }

  @override
  Future<void> updateUser(User user) {
    return userCollection.doc(user.id).update(user.toEntity().toDocument());
  }
}
