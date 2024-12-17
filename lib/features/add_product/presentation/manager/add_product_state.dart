import 'package:equatable/equatable.dart';

abstract class AddProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddProductInitial extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductSuccess extends AddProductState {}

class AddProductFailure extends AddProductState {
  final String error;

  AddProductFailure(this.error);

  @override
  List<Object?> get props => [error];
}
