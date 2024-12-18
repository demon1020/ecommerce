import '/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = Routes();
    return ScreenUtilInit(
      designSize: Size(ScreenUtilSize.width, ScreenUtilSize.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: Providers.getAllProviders(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routes.router,
            themeMode: ThemeMode.light,
            theme: Theme.of(context).copyWith(
              useMaterial3: true,
              primaryColor: AppColor.primary,
              colorScheme: ColorScheme.light(onPrimary: AppColor.primary),
            ),
          ),
        );
      },
    );
  }
}
