import 'package:ecommerce/dashboard.dart';
import 'package:ecommerce/features/home/presentation/pages/home_page.dart';

import '../../core.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String root = '/';
  static const String homePage = '/homePage';

  GoRouter get router => _goRouter;
  final secureStorage = sl<SecureStorageRepository>();

  late final GoRouter _goRouter = GoRouter(
    initialLocation: root,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      // final bool loggedIn =
      //     await secureStorage.read<bool>(Flags.isLoggedIn) ?? false;
      // final bool navigateToHomeScreen =
      //     state.fullPath.toString().startsWith(homeScreen);
      // if (!loggedIn && navigateToHomeScreen) {
      //   return loginScreen;
      // }
      // return null; // Proceed to the requested page
    },
    routes: [
      GoRoute(
        path: root,
        builder: (context, state) => DashboardScreen(),
      ),
      GoRoute(
        path: homePage,
        builder: (context, state) => HomePage(),
      ),
      // GoRoute(
      //   path: loginPage,
      //   builder: (context, state) => LoginPage(),
      // ),
    ],
  );
}
