import 'package:flutter_spinkit/flutter_spinkit.dart';

import '/core.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final Gradient? gradient;
  final bool resizeToAvoidBottomInset;
  final List<Widget>? persistentFooterButtons;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool primary;
  final bool isSafe;
  final bool isLoading;

  const AppScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.gradient,
    this.resizeToAvoidBottomInset = true,
    this.persistentFooterButtons,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.primary = true,
    this.isSafe = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      FocusScope.of(context).unfocus();
    }
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar,
          body: isSafe ? SafeArea(child: body!) : body,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          drawer: drawer,
          endDrawer: endDrawer,
          backgroundColor: backgroundColor ?? Colors.transparent,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          persistentFooterButtons: persistentFooterButtons,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          extendBody: extendBody,
          primary: primary,
        ),
        isLoading
            ? Container(
                height: ScreenUtil().screenHeight,
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  color: AppColor.black.withOpacity(0.5),
                ),
                child: Center(
                  child: SpinKitFadingCircle(
                    color: AppColor.primary,
                    size: 70.h,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
