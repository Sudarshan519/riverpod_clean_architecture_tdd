import 'package:khalti_task/features/home/data/datasource/bank_remote_datasource.dart';
import 'package:khalti_task/shared/data/remote/network_service.dart';
import 'package:khalti_task/shared/domain/models/response.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/bank/dummy_banklist.dart';
import '../../../../fixtures/dummy_data.dart';

void main() async {
  late NetworkService mockNetworkService;
  late BankDatasource bankDatasource;
  setUpAll(() {
    mockNetworkService = MockNetworkService();
    bankDatasource = BankRemoteDatasource(mockNetworkService);
  });
  group(
    'Bank Remote Datasource Test\n',
    () {
      test(
          'should return BankResponseModel on success and the data is in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: ktestBankResponseModel,
          ).toRight,
        );

        // act
        final resp = await bankDatasource.fetchBanks(skip: 0);

        // assert
        expect(resp.isRight(), true);
      });
      test(
          'should return [BankResponseModel] on success and the data is not in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: {},
          ).toRight,
        );

        // act
        final resp = await bankDatasource.fetchBanks(skip: 0);

        // assert
        expect(resp.isRight(), true);
      });
      test('should return [AppException] on success but the data is null',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: null,
          ).toRight,
        );

        // act
        final resp = await bankDatasource.fetchBanks(skip: 0);

        // assert
        expect(resp.isLeft(), true);
      });
      test('should return [AppException] on failure', () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => ktestAppException.toLeft,
        );

        // act
        final resp = await bankDatasource.fetchBanks(skip: 0);

        // assert
        expect(resp.isLeft(), true);
      });
    },
  );
  group(
    'Bank Remote Datasource Test(Search)\n',
    () {
      test(
          'Should return [BankResponseModel] on success and the data is in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: ktestBanklist,
          ).toRight,
        );

        // act
        final resp = await bankDatasource.searchBanks(skip: 0, query: '');

        // assert
        expect(resp.isRight(), true);
      });
      test(
          'should return [BankResponseModel] on success and the data is not in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: {},
          ).toRight,
        );

        // act
        final resp = await bankDatasource.searchBanks(skip: 0, query: '');

        // assert
        expect(resp.isRight(), true);
      });
      test('should return AppException on success but the data is null',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: null,
          ).toRight,
        );

        // act
        final resp = await bankDatasource.searchBanks(skip: 0, query: '');

        // assert
        expect(resp.isLeft(), true);
      });
      test('should return AppException on failure', () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => ktestAppException.toLeft,
        );

        // act
        final resp = await bankDatasource.searchBanks(skip: 0, query: '');

        // assert
        expect(resp.isLeft(), true);
      });
    },
  );
}

class MockNetworkService extends Mock implements NetworkService {}
