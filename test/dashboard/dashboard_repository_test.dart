

import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/src/features/dashboard/data/datasource/dashboard_remote_datasource.dart';
import 'package:expense_tracker/src/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:expense_tracker/src/features/dashboard/domain/income_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dashboard_repository_test.mocks.dart';

@GenerateMocks([DashboardRemoteDatasource])

void main(){

  late MockDashboardRemoteDatasource mockDashboardRemoteDatasource;
  late DashboardRepositoryImpl dashboardRepository;
  late Map<String, dynamic> data;
  late List<IncomeModel> allIncome;
  late Map<String, dynamic> incomeRequestBody;

  setUp((){
    mockDashboardRemoteDatasource = MockDashboardRemoteDatasource();
    dashboardRepository = DashboardRepositoryImpl(
      dashboardRemoteDatasource: mockDashboardRemoteDatasource
    );
    data = {};
    allIncome = [];
    incomeRequestBody = {
      "nameOfRevenue": "salary",
      "amount": 500
    };
  });

  group('TESTING DASHBOARD REPOSITORY IMPLEMENTATIONS\n', () {
    test('Test Add Income Successful', () async{
      when(mockDashboardRemoteDatasource.addIncome(requestBody: incomeRequestBody)).thenAnswer((_) async => data);

      /// Act
      final results = await dashboardRepository.addIncome(requestBody: incomeRequestBody);
      final matcher = Right<Failure, Map<String, dynamic>>(data);

      /// Assert
      verify(mockDashboardRemoteDatasource.addIncome(requestBody: incomeRequestBody));
      expect(results, matcher);
    });

    test('Test Get Income Successful', () async{
      when(mockDashboardRemoteDatasource.fetchUserIncome()).thenAnswer((_) async => allIncome);

      /// Act
      final results = await dashboardRepository.fetchUserIncome();
      final matcher = Right<Failure, List<IncomeModel>>(allIncome);

      /// Assert
      verify(mockDashboardRemoteDatasource.fetchUserIncome());
      expect(results, matcher);
    });
  });
}
