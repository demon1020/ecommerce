import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppGradientLinearIndicator extends StatelessWidget {
  final double value;

  const AppGradientLinearIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 8.0.h,
        decoration: BoxDecoration(
          color:  Color(0xffFFE8DE),
          borderRadius: BorderRadius.circular(5.0.sp),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  width: constraints.maxWidth * value,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xffE75B23), Color(0xffBD3E0B)],
                    ),
                    borderRadius: BorderRadius.circular(5.0.sp),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}