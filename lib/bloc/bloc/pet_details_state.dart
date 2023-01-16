part of 'pet_details_bloc.dart';

enum PetStateDetails { unitiliazed, initialized }

class PetDetailsState extends Equatable {
  final Pet pet;
  final PetStateDetails state;

  const PetDetailsState._(
      {this.pet = Pet.empty, this.state = PetStateDetails.unitiliazed});

  const PetDetailsState.uninitialized() : this._();

  const PetDetailsState.initialized({required Pet pet})
      : this._(pet: pet, state: PetStateDetails.initialized);

  @override
  List<Object> get props => [pet, state];
}
