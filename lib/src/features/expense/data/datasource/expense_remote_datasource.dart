
import 'package:expense_tracker/core/services/logger_service.dart';
import 'package:expense_tracker/src/features/expense/domain/expense_model.dart';
import '../../../../../core/services/api_routes.dart';
import '../../../../../core/services/http_service_requester.dart';

abstract class ExpenseRemoteDatasource{
  Future<List<ExpenseModel>> fetchUserExpenditure();
  Future<Map<String, dynamic>> addExpenditure({required Map<String, dynamic> requestBody});
}

class ExpenseRemoteDatasourceImpl extends ExpenseRemoteDatasource {
  ExpenseRemoteDatasourceImpl({required this.httpServiceRequester,});

  final HttpServiceRequester httpServiceRequester;

  @override
  Future<List<ExpenseModel>> fetchUserExpenditure() async{
    final response = await httpServiceRequester.getRequest(
      endpoint: ApiRoutes.userExpenditure,
    );

    var body = response.data;
    ZLoggerService.logOnInfo("${body['data']}");

    return ExpenseList.fromJson(body['data'] ?? []).list;
  }

  @override
  Future<Map<String, dynamic>> addExpenditure({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.userExpenditure,
      requestBody: requestBody
    );

    var body = response.data;
    ZLoggerService.logOnInfo("$body");

    return body;
  }


}