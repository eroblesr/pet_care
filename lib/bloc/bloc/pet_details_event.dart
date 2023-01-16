part of 'pet_details_bloc.dart';

abstract class PetDetailsEvent extends Equatable {
  const PetDetailsEvent();

  @override
  List<Object> get props => [];
}

@immutable
class InitPetDetails extends PetDetailsEvent {
  const InitPetDetails({required this.pet});

  final Pet pet;

  @override
  List<Object> get props => [pet];
}
