
import 'dart:io';
import 'package:flutter/material.dart';

import '../routing/app_navigator.dart';
import '../routing/app_route.dart';
import '../services/git_it_service_locator.dart';
import '../services/local_storage_service.dart';

class HelperUtil{
  static void logOut(){
    sl.get<LocalStorageService>().clearOnLogout();
    AppNavigator.pushNamedAndRemoveUntil(AppNavigator.navigatorKey.currentContext!, AppRoute.onboardingScreen, (route) => false);
  }

  static bool get isIOS => Platform.isIOS;

  static int get timeOutSeconds => 30;

  static String addZeroToSingleInteger(int? time) => (time?? 0).toString().padLeft(2, '0');

  static String get getOSPlatform {
    if (Platform.isAndroid) return 'android';

    if (Platform.isIOS) return 'ios';

    return 'unknown';
  }

  static Color getUniqueColor(String id) {
    final colorList = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      // Add more colors as needed
    ];

    final hash = id.hashCode;
    final index = hash % colorList.length;
    return colorList[index];
  }

}