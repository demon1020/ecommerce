import '/core.dart';

class AppBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const AppBottomBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69.0,
      width: double.infinity,
      color: AppColor.whitebackgroundcolor,
      child: BottomNavigationBar(
        backgroundColor: AppColor.whitebackgroundcolor,
        currentIndex: selectedIndex,
        onTap: onTabSelected,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: AppColor.primary, fontSize: AppSizes.fontSmall,fontWeight: FontWeight.w400),
        unselectedLabelStyle: TextStyle(color: AppColor.bottomTextColor, fontSize: AppSizes.fontSmall,fontWeight: FontWeight.w400),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.myMatchIcon,
              height: 24.0.h,
              width: 24.0.w,
            ),
            label: AppConstant.myMatch,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.intrestIcon,
              height: 24.0.h,
              width: 24.0.w,
            ),
            label: AppConstant.interest,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.chatIcon,
              height: 24.0.h,
              width: 24.0.w,
            ),
            label: AppConstant.chat,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.profileIcon,
              height: 24.0.h,
              width: 24.0.w,
            ),
            label: AppConstant.profile,
          ),
        ],
      ),
    );
  }
}
