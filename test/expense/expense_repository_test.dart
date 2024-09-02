
import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failure.dart';
import 'package:expense_tracker/src/features/expense/data/datasource/expense_remote_datasource.dart';
import 'package:expense_tracker/src/features/expense/data/repository/expense_repository.dart';
import 'package:expense_tracker/src/features/expense/domain/expense_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'expense_repository_test.mocks.dart';

@GenerateMocks([ExpenseRemoteDatasource])

void main(){

  late MockExpenseRemoteDatasource mockExpenseRemoteDatasource;
  late ExpenseRepositoryImpl expenseRepository;
  late Map<String, dynamic> data;
  late List<ExpenseModel> allExpenses;
  late Map<String, dynamic> expenditureRequestBody;

  setUp((){
    mockExpenseRemoteDatasource = MockExpenseRemoteDatasource();
    expenseRepository = ExpenseRepositoryImpl(
      expenseRemoteDatasource: mockExpenseRemoteDatasource,
    );
    data = {};
    allExpenses = [];
    expenditureRequestBody = {
      "category": "transport",
      "nameOfItem": "transport",
      "estimatedAmount": 500
    };
  });

  group('TESTING EXPENSE REPOSITORY IMPLEMENTATIONS\n', () {
    test('Test Add Expenses Successful', () async{
      when(mockExpenseRemoteDatasource.addExpenditure(requestBody: expenditureRequestBody)).thenAnswer((_) async => data);

      /// Act
      final results = await expenseRepository.addExpenditure(requestBody: expenditureRequestBody);
      final matcher = Right<Failure, Map<String, dynamic>>(data);

      /// Assert
      verify(mockExpenseRemoteDatasource.addExpenditure(requestBody: expenditureRequestBody));
      expect(results, matcher);
    });

    test('Test Get Expenses Successful', () async{
      when(mockExpenseRemoteDatasource.fetchUserExpenditure()).thenAnswer((_) async => allExpenses);

      /// Act
      final results = await expenseRepository.fetchUserExpenditure();
      final matcher = Right<Failure, List<ExpenseModel>>(allExpenses);

      /// Assert
      verify(mockExpenseRemoteDatasource.fetchUserExpenditure());
      expect(results, matcher);
    });

  });

}