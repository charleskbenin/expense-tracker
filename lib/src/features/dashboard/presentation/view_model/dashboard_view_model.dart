
import 'dart:collection';
import 'package:expense_tracker/src/features/dashboard/domain/income_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/view_models/base_view_model.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../../../shared_widgets/modals/success_modal_content.dart';
import '../../data/repository/dashboard_repository.dart';

class DashboardViewModel extends BaseViewModel {
  final _dashboardRepository = sl.get<DashboardRepository>();

  static List<IncomeModel> _userIncome = [];

  UnmodifiableListView<IncomeModel> get getUserIncome => UnmodifiableListView(_userIncome);

  void setUserIncome(List<IncomeModel> data, [bool append = false]) {
    _userIncome = data;
  }

  Future<void> fetchUserIncome(BuildContext context,
      {String loadingComponent = 'fetchUserIncome'}) async {
    setComponentErrorType = null;
    setLoading(true, component: loadingComponent);

    final result = await _dashboardRepository.fetchUserIncome();

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': loadingComponent
      };
      setLoading(false, component: loadingComponent);
    }, (right) {
      setUserIncome(right);
      setLoading(
        false,
        component: loadingComponent,
      );
    });
  }

  Future<void> addIncome(BuildContext context,
      {required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);
    final result = await _dashboardRepository.addIncome(requestBody: requestBody);
    if (context.mounted) AppNavigator.pop(context);

    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        AppDialogUtil.popUpModal(
          context,
          modalContent: ErrorModalContent(
            errorMessage: FailureToMessage.mapFailureToMessage(failure),
          ),
        );
      });
    }, (right) {
      AppDialogUtil.popUpModal(
        context,
        modalContent: SuccessModalContent(
          title: 'Income Added!',
          message: '${right['message'] ?? ''}',
          onButtonPressed: () async {
            AppNavigator.of(context)
              ..pop()
              ..pop();
            await fetchUserIncome(context);
          },
        ),
      );
    });
  }

}