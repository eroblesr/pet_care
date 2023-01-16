import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pet_repository/pet_repository.dart';

part 'pet_details_event.dart';
part 'pet_details_state.dart';

class PetDetailsBloc extends Bloc<PetDetailsEvent, PetDetailsState> {
  PetDetailsBloc() : super(PetDetailsState.uninitialized()) {
    on<InitPetDetails>(_onPetInitialized);
  }
  void _onPetInitialized(
    InitPetDetails event,
    Emitter<PetDetailsState> emit,
  ) {
    emit(PetDetailsState.initialized(pet: event.pet));
  }
}
