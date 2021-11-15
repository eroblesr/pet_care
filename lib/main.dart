import 'package:flutter/material.dart';
import 'package:pet_care/widgets/widgets.dart';

import 'models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fifi =
        HomeCardModel(title: "Fifi", location: "Cumbres", photo: "photo.jpeg");
    final fifiWidget = HomeCardWidget(model: fifi);
    final oreo =
        HomeCardModel(title: "Oreo", location: "Cumbres", photo: "oreo.jpeg");
    final oreoWidget = HomeCardWidget(model: oreo);
    final oli =
        HomeCardModel(title: "Oli", location: "Grulla", photo: "oli.jpeg");
    final oliWidget = HomeCardWidget(model: oli);
    final ratona = HomeCardModel(
        title: "Ratona", location: "Grulla", photo: "ratona.jpeg");
    final ratonaWidget = HomeCardWidget(model: ratona);
    final ayaka =
        HomeCardModel(title: "Ayaka", location: "Cumbres", photo: "ayaka.jpeg");
    final ayakaWidget = HomeCardWidget(model: ayaka);
    return ListView(
      children: [fifiWidget, oreoWidget, oliWidget, ratonaWidget, ayakaWidget],
    );
  }
}
