//test for filename
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khalti_task/features/home/data/datasource/bank_remote_datasource.dart';
import 'package:khalti_task/features/home/data/repositories/bank_repository.dart';
import 'package:khalti_task/features/home/domain/repositories/bank_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/bank/dummy_banklist.dart';
import '../../../../fixtures/dummy_data.dart';

void main() {
  late BankDatasource homeDatasource;
  late BankRepository homeRepository;
  setUpAll(() {
    homeDatasource = MockRemoteDatasource();
    homeRepository = BankRepositoryImpl(homeDatasource);
  });

  group('home Repository Test\n', () {
    test('Should return [BankResponseModel] on success', () async {
      // arrange
      when(() => homeDatasource.fetchBanks(skip: any(named: 'skip')))
          .thenAnswer(
        (_) async => Right(ktestBankResponseModel),
      );

      // assert
      final response = await homeRepository.fetchBanks(skip: 0);

      // act
      expect(response.isRight(), true);
    });
    test(
      'Should return [AppException] on failure',
      () async {
        // arrange
        when(() => homeDatasource.fetchBanks(skip: any(named: 'skip')))
            .thenAnswer(
          (_) async => Left(ktestAppException),
        );

        // assert
        final response = await homeRepository.fetchBanks(skip: 1);

        // act
        expect(response.isLeft(), true);
      },
    );
  });}

class MockRemoteDatasource extends Mock implements BankRemoteDatasource {}
