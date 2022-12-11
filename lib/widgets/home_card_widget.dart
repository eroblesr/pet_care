import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/models/home_card_model.dart';
import 'package:pet_repository/pet_repository.dart';

class HomeCardWidget extends StatefulWidget {
  const HomeCardWidget();
  static Page page() => const MaterialPage<void>(child: HomeCardWidget());

  @override
  State<HomeCardWidget> createState() => _HomeCardWidgetState();
}

class _HomeCardWidgetState extends State<HomeCardWidget> {
  late FirebasePetRepository petRepository;

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
          return Card(
            child: SizedBox(
              height: 160,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      backgroundImage: NetworkImage(pet.photoUrl),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(pet.name),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Text(pet.location),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
          ;
        }).toList());
      },
    );
  }
}
