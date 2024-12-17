import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/checkout_bloc.dart';
import '../manager/checkout_event.dart';
import '../manager/checkout_state.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          // Show a mock message when checkout is successful
          if (state.cart.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Checkout successful!')),
            );
          }
        },
        builder: (context, state) {
          return state.cart.isEmpty
              ? Center(child: Text('No items in the cart'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cart.length,
                        itemBuilder: (context, index) {
                          final product = state.cart[index];
                          return ListTile(
                            title: Text(product.title ?? 'No Name'),
                            subtitle: Text('\$${product.price}'),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () {
                                // Remove product from cart
                                context
                                    .read<CheckoutBloc>()
                                    .add(RemoveProductFromCart(product));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total: \$${state.totalAmount}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Proceed to checkout
                          context.read<CheckoutBloc>().add(Checkout());
                        },
                        child: Text('Checkout'),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
