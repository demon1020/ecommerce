import '/core.dart';

class AppOtpVerifiedDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const AppOtpVerifiedDialog({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 10),
          Container(
            width: 64,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(11),
            ),
          ),
          SizedBox(height: 20.h),
          Image.asset(
            imagePath,
            width: 177.w,
            height: 184.h,
          ),
          SizedBox(height: 19.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.primarytextnew,
                fontSize: AppSizes.fontExtraLarge,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter'),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.secondarytextcolor,
                fontSize: AppSizes.fontSmalle,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter'),
          ),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.all(20.0.sp),
            child: AppPrimaryButton(
                label: AppConstant.countinue, onClick: onButtonPressed),
          ),
          SizedBox(height: 43.h),
        ],
      ),
    );
  }
}
