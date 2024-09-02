
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/income_model.dart';
import '../datasource/dashboard_remote_datasource.dart';

abstract class DashboardRepository{
  Future<Either<Failure, List<IncomeModel>>> fetchUserIncome();
  Future<Either<Failure, Map<String, dynamic>>> addIncome({required Map<String, dynamic> requestBody});

}

class DashboardRepositoryImpl extends DashboardRepository {
  DashboardRepositoryImpl(
      {required this.dashboardRemoteDatasource});

  final DashboardRemoteDatasource dashboardRemoteDatasource;

  @override
  Future<Either<Failure, List<IncomeModel>>> fetchUserIncome() async{
    try{
      final response = await dashboardRemoteDatasource.fetchUserIncome();
      return Right(response);
    }catch(e, s){
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addIncome({required Map<String, dynamic> requestBody}) async{
    try{
      final response = await dashboardRemoteDatasource.addIncome(requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }



}