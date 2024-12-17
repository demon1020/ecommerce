import '/core.dart';

class AppBackiconWithText extends StatelessWidget {
  final String title;
  final VoidCallback onBackTap;

  const AppBackiconWithText({
    Key? key,
    required this.title,
    required this.onBackTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBackTap,
          child: Icon(
            Icons.arrow_back_ios,
            size: AppSizes.iconSmall,
            color: AppColor.iconcolor,
          ),
        ),
        Expanded(
          child: Center(
            child: AppTextWidget(
              text: title,
              fontSize: AppSizes.fontMedium,
              fontWeight: FontWeight.w600,
              color: AppColor.primarytextcolor,
            ),
          ),
        ),
      ],
    );
  }
}
