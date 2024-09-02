import 'package:get_it/get_it.dart';

import 'data/datasource/expense_remote_datasource.dart';
import 'data/repository/expense_repository.dart';

void initExpense(){
  final sl = GetIt.instance;

  sl.registerLazySingleton<ExpenseRemoteDatasource>(() => ExpenseRemoteDatasourceImpl(httpServiceRequester: sl()));
  sl.registerLazySingleton<ExpenseRepository>(() => ExpenseRepositoryImpl(
    expenseRemoteDatasource: sl(),
  ));
}