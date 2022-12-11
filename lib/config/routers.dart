import 'package:flutter/cupertino.dart';
import 'package:pet_care/bloc/app/bloc/app_bloc.dart';
import 'package:pet_care/widgets/login_page.dart';
import 'package:pet_care/widgets/widgets.dart';

List<Page> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeCardWidget.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
