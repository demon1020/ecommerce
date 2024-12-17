import '/core.dart';

class AppTitleDescriptionWidget extends StatelessWidget {
  const AppTitleDescriptionWidget({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
  });
  final String firstTitle;
  final String secondTitle;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(firstTitle,
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: AppSizes.fontMedium,
              fontWeight: FontWeight.w600,
              color: AppColor.secondarytextcolor)),
      SizedBox(
        height: 5.h,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(secondTitle,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: AppSizes.fontMedium,
                fontWeight: FontWeight.w600,
                color: AppColor.primarytextcolor)),
      ),
    ]);
  }
}
