import 'package:flutter/cupertino.dart';
import 'package:pet_care/bloc/app/bloc/app_bloc.dart';
import 'package:pet_care/widgets/login_page.dart';
import 'package:pet_care/widgets/pet_details.dart';
import 'package:pet_care/widgets/widgets.dart';

List<Page> onGenerateAppViewPages(
  AppState state,
  List<Page<dynamic>> pages,
) {
  switch (state.status) {
    case AppStatus.authenticated:
      switch (state.screen) {
        case Screen.none:
        case Screen.home:
          return [HomeCardWidget.page()];
        case Screen.petDetails:
          return [PetDetails.page()];
      }
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
