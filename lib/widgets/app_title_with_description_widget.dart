import '/core.dart';

class AppTitleWithDescription extends StatelessWidget {
  final String title;
  final String description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsetsGeometry? padding;

  const AppTitleWithDescription({
    Key? key,
    required this.title,
    required this.description,
    this.titleStyle,
    this.descriptionStyle,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(18.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          AppTextWidget(
            text: title,
            fontSize: titleStyle?.fontSize ?? AppSizes.fontMedium,
            color: titleStyle?.color ?? AppColor.primarytextwhitecolor,
            fontWeight: titleStyle?.fontWeight ?? FontWeight.bold,
          ),
          SizedBox(height: 4.h),

          // Description
          Center(
            child: AppTextWidget(
              text: description,
              fontSize: descriptionStyle?.fontSize ?? AppSizes.fontSmall,
              color: descriptionStyle?.color ?? AppColor.primarytextwhitecolor,
              fontWeight: descriptionStyle?.fontWeight,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
