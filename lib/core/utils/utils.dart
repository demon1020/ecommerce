import 'package:intl/intl.dart';

import '/core.dart';

enum Result { success, general, error }

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static void fieldFocusChange(FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(navigatorKey.currentContext!).requestFocus(nextFocus);
  }

  static void flushBar(String message,
      {Result result = Result.error, int duration = 2}) {
    showFlushbar(
      context: navigatorKey.currentContext!,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: duration),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: result == Result.error
            ? FlushbarPosition.TOP
            : FlushbarPosition.BOTTOM,
        backgroundColor: getColor(result),
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(navigatorKey.currentContext!),
    );
  }

  static snackBar(String message,
      {Result result = Result.general, int duration = 3}) {
    return ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: getColor(result),
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }

  static String formatCurrency(num amount,
      {String locale = 'en_IN', String symbol = "₹ "}) {
    final format = NumberFormat.currency(locale: locale, symbol: symbol);
    return format.format(amount);
  }

  static Color getColor(Result result) {
    if (result == Result.general) {
      return AppColor.primary;
    }
    if (result == Result.error) {
      return AppColor.black.withOpacity(0.7);
    }
    if (result == Result.success) {
      return AppColor.green.shade500;
    }
    return AppColor.primary;
  }
}
