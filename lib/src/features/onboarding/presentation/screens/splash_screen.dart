import 'package:expense_tracker/core/constants/colors.dart';
import 'package:expense_tracker/core/extensions/widgets/text_extension.dart';
import 'package:expense_tracker/core/routing/app_navigator.dart';
import 'package:expense_tracker/core/routing/app_route.dart';
import 'package:expense_tracker/core/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Future.delayed(const Duration(milliseconds: 300));
      _controller.forward();
      await Future.delayed(const Duration(milliseconds: 2500));
      if(!mounted) return;

      if(await context.read<UserViewModel>().isLoggedIn()){
        if(!mounted) return;
        await fetchPersistedLocalData();

        if(!mounted) return;
        AppNavigator.pushReplacementNamed(context, AppRoute.homeScreen);
        return;
      }

      if(!mounted) return;
      AppNavigator.pushReplacementNamed(context, AppRoute.onboardingScreen);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: kBlue800,
        body: ScaleTransition(
          scale: _animation,
          child: Center(
            child: const Text("L•E•T").extraBold().fontSize(44).color(kPrimaryWhite)
          ),
        ),
      ),
    );
  }

  Future<void> fetchPersistedLocalData() async{
    // FETCH DATA IN PERSISTED LOCAL DATABASES
    await context.read<UserViewModel>().initState();
  }
}
