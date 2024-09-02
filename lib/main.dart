import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:expense_tracker/core/services/git_it_service_locator.dart';
import 'package:expense_tracker/core/utils/app_theme_util.dart';
import 'package:expense_tracker/core/view_models/user_view_model.dart';
import 'package:expense_tracker/src/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:expense_tracker/src/features/expense/presentation/view_model/expense_view_model.dart';
import 'package:expense_tracker/src/features/home/presentation/view_models/bottom_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/routing/app_navigator.dart';
import 'core/routing/app_route.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    setUpGetItServiceLocator();

    runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider<UserViewModel>(create: (context) => UserViewModel()),
            ChangeNotifierProvider<BottomNavViewModel>(create: (context) => BottomNavViewModel()),
            ChangeNotifierProvider<ExpenseViewModel>(create: (context) => ExpenseViewModel()),
            ChangeNotifierProvider<DashboardViewModel>(create: (context) => DashboardViewModel()),
          ],
          child: const MyApp(),
        ),
      ),
    );
  }, (error, stack) async {
    // Record Crush
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: (context, _) {
            var child = _!;
            child = DevicePreview.appBuilder(context, _);
            return child;
          },
          theme: AppThemeUtil.lightTheme,
          initialRoute: AppRoute.splashScreen,
          onGenerateRoute: AppNavigator.generateRoute,
          navigatorKey: AppNavigator.navigatorKey,
        );
      },
    );
  }
}
