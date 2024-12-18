import 'package:ecommerce/core.dart';
import 'package:ecommerce/features/home/data/models/product_model.dart';

import '../../../../core/data/repositories/hive_service.dart';
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
                  return ProductCard(product: product);
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

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: product.image!,
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight / 3,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(Icons.image_not_supported, size: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  text: product.title ?? 'No Name',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                AppTextWidget(
                  text: "Sold by: ${product.seller?.username}" ?? 'No Name',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppTextWidget(
                        text: "₹ ${product.price?.totalAmount?.amount}" ?? '0',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.green,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20, child: VerticalDivider()),
                    // Expanded(
                    //   child: InkWell(
                    //     onTap: () {
                    //       context
                    //           .read<CheckoutBloc>()
                    //           .add(AddProductToCart(product));
                    //       Utils.snackBar("Product added to cart");
                    //     },
                    //     child: AppTextWidget(
                    //       text: "Buy Now" ?? '0',
                    //       fontSize: 18.sp,
                    //       fontWeight: FontWeight.bold,
                    //       color: AppColor.primary,
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: AppPrimaryButton(
                        onClick: () {
                          context
                              .read<CheckoutBloc>()
                              .add(AddProductToCart(product));
                          Utils.snackBar("Product added to cart");
                        },
                        label: 'Buy Now',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
