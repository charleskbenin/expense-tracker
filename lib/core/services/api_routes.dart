import 'api_config.dart';

class ApiRoutes {
  static final String _baseUrl = ApiConfig.baseURL;

  /// AUTH SERVICE
  static get signup => '$_baseUrl/auth/signup';
  static get login => '$_baseUrl/auth/login';

  /// USER EXPENDITURE
  static get userExpenditure => '$_baseUrl/user/expenditure';

  /// USER INCOME
  static get userIncome => '$_baseUrl/user/income';



}
