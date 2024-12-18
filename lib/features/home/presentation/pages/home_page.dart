import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repositories/hive_service.dart';
import '../../../../core/di/injector.dart';
import '../../../checkout/presentation/manager/checkout_bloc.dart';
import '../../../checkout/presentation/manager/checkout_event.dart';
import '../manager/home_bloc.dart';
import '../manager/home_event.dart';
import '../manager/home_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final int initialPage = 1;
  late ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = sl<ProductBloc>();
    _productBloc.add(LoadProductsEvent(initialPage));

    CheckoutBloc(HiveService()).add(LoadCart());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        final currentState = _productBloc.state;
        if (currentState is ProductLoaded && !currentState.hasReachedMax) {
          final nextPage =
              (currentState.products.length ~/ ProductBloc.itemsPerPage) + 1;
          _productBloc.add(LoadProductsEvent(nextPage));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _productBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        bloc: _productBloc,
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductInitial ||
              state is ProductLoading && state is! ProductLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.products.length
                  : state.products.length + 1,
              itemBuilder: (context, index) {
                if (index < state.products.length) {
                  final product = state.products[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading: product.image != null
                          ? Image.network(
                              product.image!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.image_not_supported, size: 50),
                      title: Text(
                        product.title ?? 'No Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Price: \$${product.price ?? 0}\nSeller: ${product.seller?.username ?? ''}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          context
                              .read<CheckoutBloc>()
                              .add(AddProductToCart(product));
                        },
                        child: Text('Buy Now'),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else if (state is ProductError) {
            return Center(
              child: Text(
                'Failed to load products. Please try again.',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
