import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/profile_bloc.dart';
import '../manager/profile_event.dart';
import '../manager/profile_state.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Trigger the FetchProfileData event when the ProfileScreen is initialized
    context.read<ProfileBloc>().add(FetchProfileData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // You can handle any side-effects here
        },
        builder: (context, state) {
          return state.productsListed.isEmpty && state.productsPurchased.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Items Sold: ${state.itemsSold}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Items Bought: ${state.itemsBought}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Products Listed:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ...state.productsListed.map(
                        (product) => ListTile(
                          title: Text(product.title ?? 'No Name'),
                          subtitle: Text('\$${product.price}'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Products Purchased:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ...state.productsPurchased.map(
                        (product) => ListTile(
                          title: Text(product.title ?? 'No Name'),
                          subtitle: Text('\$${product.price}'),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
