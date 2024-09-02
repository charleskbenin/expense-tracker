import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/auth/data/datasources/user_local_datasource.dart';
import 'package:expense_tracker/core/auth/data/datasources/user_remote_datasource.dart';
import 'package:expense_tracker/core/auth/data/repositories/user_repository.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_test.mocks.dart';


@GenerateMocks([UserRemoteDatasource, UserLocalDatasource])
void main(){
  late MockUserRemoteDatasource mockUserRemoteDatasource;
  late MockUserLocalDatasource mockUserLocalDatasource;
  late UserRepositoryImpl userRepository;
  late Map<String, dynamic> data;
  late Map<String, dynamic> loginRequestBody;
  late Map<String, dynamic> signupRequestBody;

  setUp((){
    mockUserRemoteDatasource = MockUserRemoteDatasource();
    mockUserLocalDatasource = MockUserLocalDatasource();
    userRepository = UserRepositoryImpl(
      userRemoteDatasource: mockUserRemoteDatasource,
      userLocalDatasource: mockUserLocalDatasource,
    );
    data = {};
    loginRequestBody = {'email': 'cbenin88@gmail.com', 'password':'password'};
    signupRequestBody = {'name':'Charles', 'email': 'cbenin88@gmail.com', 'password':'password'};
  });



  group('TESTING USER REPOSITORY IMPLEMENTATIONS\n', () {
    test('Test Login Successful', () async{
      when(mockUserRemoteDatasource.login(requestBody: loginRequestBody)).thenAnswer((_) async => data);

      /// Act
      final results = await userRepository.login(requestBody: loginRequestBody);
      final matcher = Right<Failure, Map<String, dynamic>>(data);

      /// Assert
      verify(mockUserRemoteDatasource.login(requestBody: loginRequestBody));
      expect(results, matcher);
    });

    test('Test Signup Successful', () async {
      when(mockUserRemoteDatasource.signup(requestBody: signupRequestBody)).thenAnswer((_) async => data);

      // Act
      final results = await userRepository.signup(requestBody: signupRequestBody);
      final matcher = Right<Failure, Map<String, dynamic>>(data);

      // Assert
      verify(mockUserRemoteDatasource.signup(requestBody: signupRequestBody)).called(1);
      expect(results, matcher);
    });
  });
}