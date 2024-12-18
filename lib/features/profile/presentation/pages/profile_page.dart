import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repositories/hive_service.dart';
import '../../../home/data/models/product_model.dart';
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
                      //Items Bought
                      Expanded(
                        child: FutureBuilder<List<Product>>(
                          future: HiveService.getAll<Product>(
                              HiveService.purchaseBox),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              List<Product> products = snapshot.data!;
                              return Text(snapshot.data!.length.toString());
                            } else {
                              return Center(child: Text('Create products!'));
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: FutureBuilder<List<Product>>(
                          future:
                              HiveService.getAll<Product>(HiveService.salesBox),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              List<Product> products = snapshot.data!;
                              return Text(snapshot.data!.length.toString());
                            } else {
                              return Center(child: Text('Create products!'));
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Products Listed:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: FutureBuilder<List<Product>>(
                          future: HiveService.getAll<Product>(
                              HiveService.productsBoxName),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              List<Product> products = snapshot.data!;
                              return Text(snapshot.data!.length.toString());
                            } else {
                              return Center(child: Text('Create products!'));
                            }
                          },
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
