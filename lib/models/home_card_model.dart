import 'package:equatable/equatable.dart';

class HomeCardModel extends Equatable {
  const HomeCardModel({
    required this.title,
    required this.location,
    required this.photo,
  });

  final String title;
  final String location;
  final String photo;

  @override
  List<Object?> get props => [title, location, photo];

  static page() {}
}
