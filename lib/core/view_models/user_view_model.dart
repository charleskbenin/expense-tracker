import 'package:expense_tracker/core/routing/app_navigator.dart';
import 'package:expense_tracker/core/view_models/base_view_model.dart';
import 'package:expense_tracker/src/shared_widgets/modals/success_modal_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../src/features/home/presentation/view_models/bottom_nav_view_model.dart';
import '../../src/shared_widgets/modals/error_modal_content.dart';
import '../auth/data/repositories/user_repository.dart';
import '../auth/domain/models/user/user_model.dart';
import '../errors/failure.dart';
import '../routing/app_route.dart';
import '../services/git_it_service_locator.dart';
import '../services/local_storage_service.dart';
import '../utils/app_dialog_util.dart';
import '../utils/helper_util.dart';

class UserViewModel extends BaseViewModel {
  final _userRepository = sl.get<UserRepository>();

  UserModel _user = const UserModel();

  set setUser(UserModel user) {
    _user = user;
    notifyListeners();
    _persistUser();
  }

  UserModel get getUser => _user;

  Future<void> authentication(BuildContext context,
      {String type = 'login',
      required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);

    final result = type == 'login'
        ? await _userRepository.login(requestBody: requestBody)
        : await _userRepository.signup(requestBody: requestBody);
    if (context.mounted) {
      AppNavigator.pop(context);
    }

    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (data) {
      if (type == 'login') {
        context.read<BottomNavViewModel>().selectNavTab = 0;
        AppNavigator.pushNamedAndRemoveUntil(
            context, AppRoute.homeScreen, (p0) => false);
      } else {
        AppDialogUtil.popUpModal(
            context,
            modalContent: SuccessModalContent(
              message: "You have successfully signed up, please login to your account",
              onButtonPressed: (){
                AppNavigator.pushNamedAndRemoveUntil(
                    context, AppRoute.onboardingScreen, (p0) => false);
              },
            )
        );
      }
    });
  }

  /// SIGN OUT
  Future<void> signOut(BuildContext context) async {
    AppDialogUtil.loadingDialog(context);
    context.read<BottomNavViewModel>().selectNavTabWithOutNotify = 0;
    await Future.delayed(const Duration(milliseconds: 500));
    if (context.mounted) AppNavigator.pop(context);
    await sl.get<LocalStorageService>().delete('accessToken');
    await LocalStorageService().clearOnLogout();
    HelperUtil.logOut();
  }

  Future<void> _retrieveUser() async {
    final result = await _userRepository.retrieveUser();
    result.fold((l) => null, (user) => _user = user);
  }

  Future<void> _persistUser() async {
    final result = await _userRepository.persistUser(_user);
    result.fold((l) => null, (user) => null);
  }

  Future<bool> isLoggedIn() async => await _userRepository.isLoggedIn();

  initState() async {
    await _retrieveUser();
  }
}
