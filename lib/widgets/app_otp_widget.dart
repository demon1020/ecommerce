import '/core.dart';

class AppOtpWidget extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final PinTheme? defaultPinTheme;
  final Color focusedBorderColor;
  final Color fillColor;
  final Color borderColor;
  final int length;

  const AppOtpWidget({
    Key? key,
    this.controller,
    this.focusNode,
    this.onCompleted,
    this.onChanged,
    this.validator,
    this.defaultPinTheme,
    this.focusedBorderColor = AppColor.primary,
    this.fillColor = const Color.fromRGBO(243, 246, 249, 0),
    this.borderColor = const Color.fromRGBO(23, 171, 144, 0.4),
    this.length = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pinTheme = defaultPinTheme ??
        PinTheme(
          width: 67.w,
          height: 58.h,
          textStyle: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.primarytextcolor,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.sp),
            border: Border.all(color: AppColor.primary),
          ),
        );

    return Pinput(
      length: length,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: pinTheme,
      separatorBuilder: (index) => SizedBox(width: 16.w),
      validator: validator,
      onCompleted: onCompleted,
      onChanged: onChanged,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: focusedBorderColor,
          ),
        ],
      ),
      focusedPinTheme: pinTheme.copyWith(
        decoration: pinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(7.sp),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      submittedPinTheme: pinTheme.copyWith(
        decoration: pinTheme.decoration!.copyWith(
          color: fillColor,
          borderRadius: BorderRadius.circular(19.sp),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      errorPinTheme: pinTheme.copyBorderWith(
        border: Border.all(color: Colors.redAccent),
      ),
    );
  }
}
