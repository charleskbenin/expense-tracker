import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../src/shared_widgets/common/app_loader.dart';
import '../constants/colors.dart';
import 'app_theme_util.dart';
import 'helper_util.dart';

enum DialogAction { yes, abort }

class AppDialogUtil {

  static Future<void> loadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: AppThemeUtil.getThemeColor(kBlack70),
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: const PopScope(
              canPop: false,
              child: SimpleDialog(
                elevation: 0.0,
                contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                titlePadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                backgroundColor: Colors.transparent,
                children: <Widget>[
                  AppLoader(),
                ],
              ),
            ),
          );
        },
    );
  }


  static Future showScrollableBottomSheet( {
    required BuildContext context,
    bool? isDismissible,
    bool useSafeArea = true,
    required Widget Function(BuildContext) builder
  })
  {
    return showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      useSafeArea: HelperUtil.isIOS? false : useSafeArea,
      isDismissible: isDismissible?? true,
      barrierColor: AppThemeUtil.getThemeColor(kBlack70),
      builder: builder,
    );
  }

  static Future<dynamic> popUpModal(BuildContext context,{
    bool willPop = true,
    bool barrierDismissible = false,
    required Widget modalContent,
  }) async {
    await showDialog(
      barrierDismissible: barrierDismissible,
      barrierColor: AppThemeUtil.getThemeColor(kBlack70),
      context: context,
      builder: (BuildContext context) {
        return  PopScope(
          canPop: willPop,
          child: modalContent,
        );
      },
    );
  }

}
