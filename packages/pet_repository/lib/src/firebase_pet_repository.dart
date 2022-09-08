import 'package:built_collection/src/list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_repository/pet_repository.dart';

class FirebasePetRepository implements PetRepository {
  final petCollection = FirebaseFirestore.instance.collection('pets');
  @override
  Future<String> addPet(PetEntity petEntity) {
    return petCollection
        .add(petEntity.toDocument())
        .then((docRef) => docRef.id);
  }

  @override
  Future<void> deleteItem(String petId) {
    return petCollection.doc(petId).delete();
  }

  @override
  Stream<BuiltList<Pet>> pets() {
    return petCollection.snapshots().map((snapshot) => snapshot.docs
        .map(
          (doc) => Pet.fromEntity(PetEntity.fromSnapshot(doc)),
        )
        .toBuiltList());
  }

  @override
  Future<void> updatePet(Pet pet) {
    return petCollection.doc(pet.id).update(pet.toEntity().toDocument());
  }
}
