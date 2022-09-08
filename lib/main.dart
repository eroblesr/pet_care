import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/widgets/widgets.dart';
import 'package:pet_repository/pet_repository.dart';

import 'firebase_options.dart';
import 'models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return const PetListWidget();
  }
}

class PetListWidget extends StatefulWidget {
  const PetListWidget({Key? key}) : super(key: key);

  @override
  _PetListWidgetState createState() => _PetListWidgetState();
}

class _PetListWidgetState extends State<PetListWidget> {
  late PetRepository petRepository;
  late Stream petStream;
  @override
  void initState() {
    petRepository = FirebasePetRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BuiltList<Pet>>(
      stream: petRepository.pets(),
      builder: (BuildContext context, AsyncSnapshot<BuiltList<Pet>> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
            children: snapshot.data!.map((Pet pet) {
          return HomeCardWidget(
              model: HomeCardModel(
            title: pet.name,
            location: pet.location,
            photo: pet.photoUrl,
          ));
        }).toList());
      },
    );
  }
}
