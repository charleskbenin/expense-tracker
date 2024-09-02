import 'package:expense_tracker/core/auth/auth_injections.dart';
import 'package:expense_tracker/core/services/http_service_requester.dart';
import 'package:get_it/get_it.dart';
import '../../src/features/dashboard/dashboard_injection.dart';
import '../../src/features/expense/expense_injection.dart';
import 'local_storage_service.dart';


GetIt sl = GetIt.instance;

void setUpGetItServiceLocator(){
  sl.registerSingleton<LocalStorageService>(LocalStorageService());
  sl.registerLazySingleton(() => HttpServiceRequester());

  initAuth();

  initExpense();

  initDashboard();


}