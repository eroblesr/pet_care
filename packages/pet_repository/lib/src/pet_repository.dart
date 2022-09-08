import 'package:built_collection/built_collection.dart';
import 'package:pet_repository/pet_repository.dart';

import 'models/models.dart';

abstract class PetRepository {
  Future<String> addPet(PetEntity petEntity);
  Stream<BuiltList<Pet>> pets();
  Future<void> updatePet(Pet pet);
  Future<void> deleteItem(String petId);
}
