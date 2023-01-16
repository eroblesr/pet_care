import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/bloc/bloc/pet_details_bloc.dart';
import 'package:pet_care/repositories/auth_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';

class PetDetails extends StatefulWidget {
  const PetDetails({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: PetDetails());
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PetDetails());
  }

  @override
  State<PetDetails> createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  late List<XFile> images;

  @override
  void initState() {
    images = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pet details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<PetDetailsBloc, PetDetailsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ' + state.pet.name),
                Text('Location: ' + state.pet.location),
                Text('Photos:'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    fixedSize: const Size(200, 40),
                  ),
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    final List<XFile>? pickedImages =
                        await _picker.pickMultiImage();
                    setState(() {
                      if (pickedImages != null) {
                        images = pickedImages;
                      }
                    });
                  },
                  child: const Text(
                    'Pick image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 1,
                    children: <Widget>[
                      for (var image in images) ...[
                        Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.teal[100],
                            child: image != null
                                ? Image.file(File(image!.path),
                                    width: 160, height: 160, fit: BoxFit.fill)
                                : Container()),
                      ],
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.teal[200],
                        child: Image.network(
                          state.pet.photoUrl,
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
