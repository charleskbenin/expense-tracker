
import 'dart:collection';

import 'package:expense_tracker/src/features/expense/data/repository/expense_repository.dart';
import 'package:expense_tracker/src/features/expense/domain/expense_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/routing/app_navigator.dart';
import '../../../../../core/services/git_it_service_locator.dart';
import '../../../../../core/utils/app_dialog_util.dart';
import '../../../../../core/view_models/base_view_model.dart';
import '../../../../shared_widgets/modals/error_modal_content.dart';
import '../../../../shared_widgets/modals/success_modal_content.dart';

class ExpenseViewModel extends BaseViewModel {
  final _expenseRepository = sl.get<ExpenseRepository>();

  static List<ExpenseModel> _userExpenditure = [];

  UnmodifiableListView<ExpenseModel> get getUserExpenditure => UnmodifiableListView(_userExpenditure);

  void setUserExpenditure(List<ExpenseModel> data, [bool append = false]) {
    _userExpenditure = data;
  }

  Future<void> fetchUserExpenditure(BuildContext context,
      {String loadingComponent = 'fetchUserExpenditure'}) async {
    setComponentErrorType = null;
    setLoading(true, component: loadingComponent);

    final result = await _expenseRepository.fetchUserExpenditure();

    result.fold((left) {
      setComponentErrorType = {
        'error': FailureToMessage.mapFailureToMessage(left),
        'component': loadingComponent
      };
      setLoading(false, component: loadingComponent);
    }, (right) {
      setUserExpenditure(right);
      setLoading(
        false,
        component: loadingComponent,
      );
    });
  }

  Future<void> addExpenditure(BuildContext context,
      {required Map<String, dynamic> requestBody}) async {
    AppDialogUtil.loadingDialog(context);
    final result = await _expenseRepository.addExpenditure(requestBody: requestBody);
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
          title: 'Expense Added!',
          message: '${right['message'] ?? ''}',
          onButtonPressed: () async {
            AppNavigator.of(context)
              ..pop()
              ..pop();
            await fetchUserExpenditure(context);
          },
        ),
      );
    });
  }

}