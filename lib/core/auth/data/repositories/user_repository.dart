
import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';
import '../../domain/models/user/user_model.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

abstract class UserRepository{
  Future<Either<Failure, Map<String, dynamic>>> signup({required Map<String, dynamic> requestBody});
  Future<Either<Failure, Map<String, dynamic>>> login({required Map<String, dynamic> requestBody});
  Future<bool> isLoggedIn();

  /// LOCAL DB
  Future<Either<Failure, UserModel>> retrieveUser();
  Future<Either<Failure, bool>> persistUser(UserModel user);
}


class UserRepositoryImpl extends UserRepository{
  UserRepositoryImpl({
    required this.userRemoteDatasource,
    required this.userLocalDatasource,
  });

  final UserRemoteDatasource userRemoteDatasource;
  final UserLocalDatasource userLocalDatasource;



  @override
  Future<Either<Failure, Map<String, dynamic>>> signup({required Map<String, dynamic> requestBody}) async{
    try{
      final response = await userRemoteDatasource.signup(requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({required Map<String, dynamic> requestBody}) async{
    try{
      final response = await userRemoteDatasource.login(requestBody: requestBody);
      return Right(response);
    }catch(e, s){
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<bool> isLoggedIn() async => await userLocalDatasource.isLoggedIn();

  @override
  Future<Either<Failure, UserModel>> retrieveUser() async{
    try {
      final response = await userLocalDatasource.retrieveUser();
      return Right(response);
    } catch (e, s) {
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, bool>> persistUser(UserModel user) async{
    try {
      await userLocalDatasource.persistUser(user);
      return const Right(true);
    } catch (e, s) {
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }
  
}