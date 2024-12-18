import '../../../../core.dart';
import '../../../../core/data/repositories/hive_service.dart';
import '../../../home/data/models/product_model.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final HiveService hiveService;

  CheckoutBloc(this.hiveService) : super(CheckoutInitial()) {
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveFromCart>(_onRemoveProductFromCart);

    on<LoadCart>(_onLoadCart);
    on<InitiatePayment>(_onInitiatePayment);
  }
  Future<void> _onRemoveProductFromCart(
      RemoveFromCart event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    await hiveService.removeProductFromCart(event.product);
    final cartProducts = await hiveService.getCartProducts();
    emit(CheckoutLoaded(cartProducts));
  }

  Future<void> _onAddProductToCart(
      AddProductToCart event, Emitter<CheckoutState> emit) async {
    try {
      emit(CheckoutLoading());
      await hiveService.addProductToCart(event.product);
      final cartProducts = await hiveService.getCartProducts();
      emit(CheckoutLoaded(cartProducts));
    } catch (e) {
      emit(CheckoutError("Failed to add product to cart"));
    }
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CheckoutState> emit) async {
    try {
      emit(CheckoutLoading());
      final cartProducts = await hiveService.getCartProducts();
      emit(CheckoutLoaded(cartProducts));
    } catch (e) {
      emit(CheckoutError("Failed to load cart"));
    }
  }

  double calculateCartTotal(List<Product> cartProducts) {
    double total = 0.0;

    try {
      for (var product in cartProducts) {
        total += double.parse(product.price!.totalAmount!.amount!);
      }
    } catch (e) {
      return 0;
    }

    return total;
  }

  Future<void> _onInitiatePayment(
      InitiatePayment event, Emitter<CheckoutState> emit) async {
    emit(CheckoutPaymentProcessing());

    try {
      RazorpayService razorpayService = RazorpayService(
        paymentSuccessCallback: (response) {
          // Handle payment success
          print("Payment Success: ${response.paymentId}");
          emit(CheckoutPaymentSuccess());
        },
        paymentFailureCallback: (response) {
          // Handle payment failure
          print("Payment Failed: ${response.message}");
          emit(CheckoutPaymentFailure(response.message.toString()));
        },
      );

      await razorpayService.openCheckout(
        amount: event.amount,
        orderId: event.orderId,
        companyName: "Cidroy",
        paymentDescription: "Purchase",
        email: "user@example.com",
        contact: "9988776577",
      );
    } catch (e) {
      emit(CheckoutPaymentFailure("Payment process failed"));
    }
  }
}
