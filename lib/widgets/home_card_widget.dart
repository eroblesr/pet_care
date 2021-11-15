import 'package:flutter/material.dart';
import 'package:pet_care/models/home_card_model.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({required this.model});

  final HomeCardModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 160,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(model.title),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(model.location),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
