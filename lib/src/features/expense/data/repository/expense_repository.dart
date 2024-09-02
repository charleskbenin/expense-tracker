
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/src/features/expense/domain/expense_model.dart';

import '../../../../../core/errors/failure.dart';
import '../datasource/expense_remote_datasource.dart';

abstract class ExpenseRepository{
  Future<Either<Failure, List<ExpenseModel>>> fetchUserExpenditure();
  Future<Either<Failure, Map<String, dynamic>>> addExpenditure({required Map<String, dynamic> requestBody});

}

class ExpenseRepositoryImpl extends ExpenseRepository {
  ExpenseRepositoryImpl(
      {required this.expenseRemoteDatasource});

  final ExpenseRemoteDatasource expenseRemoteDatasource;

  @override
  Future<Either<Failure, List<ExpenseModel>>> fetchUserExpenditure() async{
    try{
      final response = await expenseRemoteDatasource.fetchUserExpenditure();
      return Right(response);
    }catch(e, s){
      print(e);
      print(s);
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addExpenditure({required Map<String, dynamic> requestBody}) async{
    try{
      final response = await expenseRemoteDatasource.addExpenditure(requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }



}