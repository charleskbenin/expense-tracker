import 'package:expense_tracker/core/services/logger_service.dart';

import '../../../services/api_routes.dart';
import '../../../services/git_it_service_locator.dart';
import '../../../services/http_service_requester.dart';
import '../../../services/local_storage_service.dart';

abstract class UserRemoteDatasource{
  Future<Map<String, dynamic>> signup({required Map<String, dynamic> requestBody});
  Future<Map<String, dynamic>> login({required Map<String, dynamic> requestBody});
}

class UserRemoteDatasourceImpl extends UserRemoteDatasource{

  UserRemoteDatasourceImpl({required this.httpServiceRequester});

  final HttpServiceRequester httpServiceRequester;



  @override
  Future<Map<String, dynamic>> signup({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.signup,
      requestBody: requestBody,
    );

    var body = response.data;
    ZLoggerService.logOnInfo("$body");

    // var accessToken = body['accessToken'];
    // await sl.get<LocalStorageService>().writeToken(accessToken??'');
    return body ?? {};
  }

  @override
  Future<Map<String, dynamic>> login({required Map<String, dynamic> requestBody}) async{
    final response = await httpServiceRequester.postRequest(
      endpoint: ApiRoutes.login,
      requestBody: requestBody,
    );

    var body = response.data;
    ZLoggerService.logOnInfo("$body");

    await sl.get<LocalStorageService>().delete('accessToken');
    var accessToken = body['accessToken'];
    await sl.get<LocalStorageService>().writeToken(accessToken??'');
    return body ?? {};
  }
}