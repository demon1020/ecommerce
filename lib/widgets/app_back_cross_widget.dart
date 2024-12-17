import 'package:flutter/cupertino.dart';

import '/core.dart';

class AppBackAndCrossButtons extends StatelessWidget {
  const AppBackAndCrossButtons(
      {super.key, required this.pageNumber, required this.allPage});

  final String? pageNumber;
  final String? allPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Padding(
            padding: EdgeInsets.only(left: AppSizes.paddingExtraSmall),
            child: Icon(
              Icons.arrow_back_ios,
              size: AppSizes.iconSmall,
              color: AppColor.iconcolor,
            ),
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$pageNumber ',
                style: TextStyle(
                  fontSize: AppSizes.fontMedium,
                  fontWeight: FontWeight.w700,
                  color: AppColor.iconcolor,
                ),
              ),
              TextSpan(
                text: 'of $allPage',
                // text: 'of $allPage',
                style: TextStyle(
                  fontSize: AppSizes.fontMedium,
                  fontWeight: FontWeight.w700,
                  color: AppColor.iconcolor,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(
            CupertinoIcons.multiply,
            size: AppSizes.iconSmall,
            color: AppColor.iconcolor,
          ),
        ),
      ],
    );
  }
}
