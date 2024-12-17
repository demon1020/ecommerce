import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  // Detect platform
  static bool isWeb = kIsWeb;
  static bool isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  static bool isIOS = !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  // Detect Tablet using MediaQuery
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  // Common font sizes
  static double fontExtraSmall = 10.sp;
  static double fontSmall = 12.sp;
  static double fontSmalle = 14.sp;
  static double fontMedium = 16.sp;
  static double fontLarge = 20.sp;
  static double fontExtraLargee = 18.sp;
  static double fontExtraLarge = 24.sp;
  static double fontTitle = 28.sp;
  static double fontHeading = 32.sp;

  // Padding and Margin
  static double paddingExtraSmall = 4.w;
  static double paddingSmall = 8.w;
  static double paddingMedium = 16.w;
  static double paddingExtraMedium = 20.w;

  static double paddingLarge = 24.w;
  static double paddingExtraLarge = 32.w;

  static double marginExtraSmall = 4.w;
  static double marginSmall = 8.w;
  static double marginMedium = 16.w;
  static double marginLarge = 24.w;
  static double marginExtraLarge = 32.w;

  // Container sizes
  static double containerHeightSmall = 50.h;
  static double containerHeightMedium = 100.h;
  static double containerHeightLarge = 200.h;

  static double containerWidthSmall = 100.w;
  static double containerWidthMedium = 200.w;
  static double containerWidthLarge = 300.w;

  // Icon sizes
  static double iconSmall = 16.w;
  static double iconMedium = 24.w;
  static double iconLarge = 32.w;

  // Border Radius
  static double radiusSmall = 8.r;
  static double radiusMedium = 16.r;
  static double radiusLarge = 24.r;

  // AppBar height
  static double appBarHeight = 56.h;

  // Dynamic container sizes based on the platform
  static double dynamicContainerHeight(BuildContext context) {
    if (isTablet(context)) return 250.h;
    if (isWeb) return 300.h;
    return 150.h;
  }

  static double dynamicContainerWidth(BuildContext context) {
    if (isTablet(context)) return 400.w;
    if (isWeb) return 500.w;
    return 300.w;
  }

  // Platform-specific padding
  static double platformPadding(BuildContext context) {
    if (isWeb) return 24.w;
    if (isTablet(context)) return 20.w;
    if (isIOS) return 16.w;
    return 12.w; // Default for Android
  }

  // Example dynamic text size based on device
  static double dynamicTextSize(BuildContext context) {
    if (isTablet(context)) return fontLarge;
    if (isWeb) return fontExtraLarge;
    return fontMedium;
  }
}
