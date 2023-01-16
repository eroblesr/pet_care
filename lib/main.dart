import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/bloc/app/bloc/app_bloc.dart';
import 'package:pet_care/bloc/bloc/pet_details_bloc.dart';
import 'package:pet_care/config/routers.dart';
import 'package:pet_care/repositories/auth_repository.dart';
import 'package:pet_care/widgets/widgets.dart';
import 'package:pet_repository/pet_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'models/models.dart';

Future<void> main() {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final userRepository = FirebaseUserRepository();
    final authRepository = AuthRepository(userRepository: userRepository);
    runApp(
        MyApp(authRepository: authRepository, userRepository: userRepository));
  });
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  const MyApp({
    Key? key,
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: RepositoryProvider.value(
        value: _userRepository,
        child: BlocProvider(
          create: (_) => AppBloc(
              authRepository: _authRepository, userRepository: _userRepository),
          child: BlocProvider(
            create: (_) => PetDetailsBloc(),
            child: AppView(),
          ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder(
        state: context.select((AppBloc bloc) => bloc.state),
        onGeneratePages: onGenerateAppViewPages,
      ),
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
  //late PetRepository petRepository;
  ///late Stream petStream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "email"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "password"),
                  obscureText: true,
                ),
                ElevatedButton(onPressed: () {}, child: const Text("Login!")),
              ],
            )));
  }
  //void initState() {
  ///petRepository = FirebasePetRepository();
  //super.initState();
  //}

  //@override
  //Widget build(BuildContext context) {
  //return StreamBuilder<BuiltList<Pet>>(
  //stream: petRepository.pets(),
  ///builder: (BuildContext context, AsyncSnapshot<BuiltList<Pet>> snapshot) {
  // if (snapshot.hasError) {
  //  return Text('Something went wrong');
  //}

  ///if (snapshot.connectionState == ConnectionState.waiting) {
  //  return Text("Loading");
  //}

  //return ListView(
  //  children: snapshot.data!.map((Pet pet) {
  //return HomeCardWidget(
  //  model: HomeCardModel(
  //  title: pet.name,
  //location: pet.location,
  //photo: pet.photoUrl,
  // ));
  // }).toList());
  // },
  // );
  //}
}
