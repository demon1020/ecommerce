import 'package:ecommerce/core.dart';
import 'package:ecommerce/features/checkout/presentation/manager/checkout_event.dart';
import 'package:ecommerce/features/home/data/models/product_model.dart';

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
            return state.cartProducts.isEmpty
                ? Center(
                    child: AppTextWidget(
                      text: "Lets go Shopping!",
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.cartProducts.length,
                          itemBuilder: (context, index) {
                            final product = state.cartProducts[index];
                            return ProductItemCard(product: product);
                          },
                        ),
                      ),
                      // Divider(),
                      Container(
                        width: ScreenUtil().screenWidth,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: AppTextWidget(
                                text:
                                    '₹${bloc.calculateCartTotal(state.cartProducts)}',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.green,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: AppPrimaryButton(
                                onClick: () {
                                  context.read<CheckoutBloc>().add(
                                      InitiatePayment(
                                          bloc.calculateCartTotal(
                                              state.cartProducts),
                                          "hgfhgfvhghv"));
                                },
                                label: 'Checkout',
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

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.product,
    this.hideDelete = false,
  });

  final Product product;
  final bool hideDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: product.image != null
          ? hideDelete
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(product.image!),
                    width: 50.h,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: product.image!,
                    width: 50.h,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                )
          : Icon(Icons.image_not_supported, size: 50),
      title: AppTextWidget(
        text: product.title,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        maxLines: 2,
        textOverflow: TextOverflow.ellipsis,
      ),
      subtitle: AppTextWidget(
        text: '₹${product.price!.totalAmount!.amount!}',
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        maxLines: 2,
        textOverflow: TextOverflow.ellipsis,
      ),
      trailing: hideDelete
          ? null
          : IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: AppColor.red,
              ),
              onPressed: () {
                // Remove product from cart
                context.read<CheckoutBloc>().add(RemoveFromCart(product));
              },
            ),
    );
  }
}
