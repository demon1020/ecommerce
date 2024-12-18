import 'package:ecommerce/features/checkout/presentation/manager/checkout_event.dart';
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
          if (state is CheckoutPaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment Successful!')),
            );
          } else if (state is CheckoutPaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment Failed: ${state.errorMessage}')),
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
                            context.read<CheckoutBloc>().add(InitiatePayment(
                                bloc.calculateCartTotal(state.cartProducts),
                                "hgfhgfvhghv"));
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
