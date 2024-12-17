import 'package:equatable/equatable.dart';

abstract class AddProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddProductFormSubmitted extends AddProductEvent {
  final String name;
  final String description;
  final int price;
  final String imagePath;

  AddProductFormSubmitted({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [name, description, price, imagePath];
}

class AddProductImagePicked extends AddProductEvent {
  final String imagePath;

  AddProductImagePicked(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}
