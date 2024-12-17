import '/core.dart';

class AppPrimaryButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onClick;

  const AppPrimaryButton({
    Key? key,
    required this.label,
    this.onClick,
    this.isLoading = false, // Default to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onClick,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColor.primary,
        backgroundColor: onClick != null
            ? AppColor.primary
            : AppColor.primary, // Enabled/Disabled color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        elevation: 0,
        minimumSize: Size.fromHeight(50.h),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
              ),
            )
          : AppTextWidget(
              text: label,
              textAlign: TextAlign.center,
              fontSize: AppSizes.fontMedium,
              // Use a consistent font size
              color: AppColor.primarytextwhitecolor,
              // Consistent text color
              fontWeight: FontWeight.w700, // Bold text weight
            ),
    );
  }
}
