import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pet_care/bloc/bloc/pet_details_bloc.dart';
import 'package:pet_care/models/home_card_model.dart';
import 'package:pet_care/widgets/pet_details.dart';
import 'package:pet_repository/pet_repository.dart';
import 'package:image_picker/image_picker.dart';

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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Location',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 20,
        title: const Text('Home'),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[900]!,
              color: Colors.grey,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.mapMarker,
                  text: 'Location',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<BuiltList<Pet>>(
        stream: petRepository.pets(),
        builder:
            (BuildContext context, AsyncSnapshot<BuiltList<Pet>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
              children: snapshot.data!.map((Pet pet) {
            return GestureDetector(
              onTap: () async {
                BlocProvider.of<PetDetailsBloc>(context)
                    .add(InitPetDetails(pet: pet));
                Navigator.of(context).push<void>(PetDetails.route());
              },
              child: Card(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 160,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.purple,
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
                ),
              ),
            );
          }).toList());
        },
      ),
    );
  }
}
