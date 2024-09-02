import 'package:expense_tracker/core/services/logger_service.dart';
import 'package:expense_tracker/src/features/dashboard/domain/income_model.dart';

import '../../../../../core/services/api_routes.dart';
import '../../../../../core/services/http_service_requester.dart';

abstract class DashboardRemoteDatasource {
  Future<List<IncomeModel>> fetchUserIncome();

  Future<Map<String, dynamic>> addIncome(
      {required Map<String, dynamic> requestBody});
}

class DashboardRemoteDatasourceImpl extends DashboardRemoteDatasource {
  DashboardRemoteDatasourceImpl({
    required this.httpServiceRequester,
  });

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<List<IncomeModel>> fetchUserIncome() async {
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.userIncome,
    );

    var body = response.data;

    ZLoggerService.logOnInfo("${body['data']}");

    return IncomeList.fromJson(body['data'] ?? []).list;
  }

  @override
  Future<Map<String, dynamic>> addIncome(
      {required Map<String, dynamic> requestBody}) async {
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.userIncome,
      requestBody: requestBody,
    );

    var body = response.data;

    return body;
  }
}
