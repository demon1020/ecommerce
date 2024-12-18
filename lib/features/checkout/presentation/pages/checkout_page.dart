import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/checkout_bloc.dart';
import '../manager/checkout_state.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<CheckoutBloc>();
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          // Show a mock message when checkout is successful
          log(state.toString());
          if (state is CheckoutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Checkout successful!')),
            );
          }
          if (state is CheckoutLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Checkout CheckoutLoaded!')),
            );
          }
        },
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CheckoutLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartProducts.length,
                    itemBuilder: (context, index) {
                      final product = state.cartProducts[index];
                      return ListTile(
                        title: Text(product.title ?? 'No Name'),
                        subtitle:
                            Text('₹${product.price!.totalAmount!.amount!}'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            // Remove product from cart
                            // context
                            //     .read<CheckoutBloc>()
                            //     .add(RemoveProductFromCart(product));
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: ScreenUtil().screenWidth,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Total : ${bloc.calculateCartTotal(state.cartProducts)}'),
                      SizedBox(
                        width: ScreenUtil().screenWidth / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            // Proceed to checkout
                            // context.read<CheckoutBloc>().add(Checkout());
                          },
                          child: Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CheckoutError) {
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
