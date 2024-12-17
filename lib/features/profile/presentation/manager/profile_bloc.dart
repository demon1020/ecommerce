import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/models/product_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    // Handle FetchProfileData event
    on<FetchProfileData>((event, emit) async {
      // Here you would fetch the profile data (mocked or from storage)
      // Simulating a delay as if fetching data from a server or local storage
      await Future.delayed(Duration(seconds: 1));

      // Mock profile data for the purpose of this example
      final productsListed = [
        Product(
            title: 'Product 1',
            price: Price(totalAmount: Amount(amount: "20"))),
        Product(
            title: 'Product 2',
            price: Price(totalAmount: Amount(amount: "30"))),
      ];
      final productsPurchased = [
        Product(
            title: 'Product 3',
            price: Price(totalAmount: Amount(amount: "50"))),
      ];

      // Emit the new profile state
      emit(ProfileState(
        itemsSold: productsListed.length,
        itemsBought: productsPurchased.length,
        productsListed: productsListed,
        productsPurchased: productsPurchased,
      ));
    });
  }
}
