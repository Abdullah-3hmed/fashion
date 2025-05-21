import 'package:equatable/equatable.dart';

class DiscoverModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final double price;
  const DiscoverModel({
    required this.name,
    required this.image,
    required this.price,
    required this.id,
  });
  @override
  List<Object> get props => [name, image, price, id];
}
