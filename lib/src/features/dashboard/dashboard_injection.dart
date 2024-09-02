import 'package:get_it/get_it.dart';

import 'data/datasource/dashboard_remote_datasource.dart';
import 'data/repository/dashboard_repository.dart';

void initDashboard(){
  final sl = GetIt.instance;

  sl.registerLazySingleton<DashboardRemoteDatasource>(() => DashboardRemoteDatasourceImpl(httpServiceRequester: sl()));
  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(
    dashboardRemoteDatasource: sl(),
  ));
}