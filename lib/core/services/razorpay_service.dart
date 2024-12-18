import '../../core.dart';

class RazorpayService {
  late Razorpay _razorpay;
  late Function(PaymentSuccessResponse) paymentSuccessCallback;
  late Function(PaymentFailureResponse) paymentFailureCallback;

  RazorpayService({
    required this.paymentSuccessCallback,
    required this.paymentFailureCallback,
  }) {
    try {
      _razorpay = Razorpay();
    } catch (e) {
      log("Razorpay Exception : $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    try {
      paymentSuccessCallback(response);
    } catch (e) {
      log("Razorpay Exception : $e");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    try {
      paymentFailureCallback(response);
    } catch (e) {
      log("Razorpay Exception : $e");
    }
  }

  Future<void> openCheckout(
      {required double amount,
      required String orderId,
      String contact = "7709551920",
      String email = "support@Cidroy.com",
      String? companyName,
      String? paymentDescription,
      String? logo}) async {
    var options = {
      'key': dotenv.env["KEY_ID"],
      'amount': (amount * 100).toInt(), // Convert to paisa
      'name': companyName,
      // 'order_id': orderId,
      'description': paymentDescription,
      'prefill': {
        'contact': contact,
        'email': email,
      },
      "image": logo,
    };

    try {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}
