import 'package:equatable/equatable.dart';

import '../../data/models/my_product_response_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;

  ProductLoaded({required this.products, required this.hasReachedMax});

  @override
  List<Object?> get props => [products, hasReachedMax];
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);

  @override
  List<Object?> get props => [error];
}
