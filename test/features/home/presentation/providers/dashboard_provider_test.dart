//test for filename
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khalti_task/features/home/domain/repositories/bank_repository.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_notifier.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_state.dart';
import 'package:khalti_task/services/bank_cache_service/domain/repositories/bank_cache_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../fixtures/bank/dummy_banklist.dart';
import '../../../../fixtures/dummy_data.dart';

void main() {
  late BankRepository bankRepository;
  late BankCacheRepository bankCacheRepository;
  late BankNotifier notifier;
  setUpAll(() {
    bankRepository = MockBankRepository();
    bankCacheRepository = MockBankCacheRepository();
    notifier = BankNotifier(bankRepository, bankCacheRepository);
  });
  stateNotifierTest<BankNotifier, BankState>(
    'Should fail when error occurs on fetch',
    build: () => BankNotifier(bankRepository, bankCacheRepository),
    setUp: () {
      when(() => bankRepository.fetchBanks(skip: 0)).thenAnswer(
        (invocation) async => Left(ktestAppException),
      );
      when(() => bankCacheRepository.hasBank()).thenAnswer(
        (invocation) async => false,
      );
    },
    actions: (notifier) async {
      await notifier.fetchBanks();
    },
    expect: () => [
      const BankState(
        state: BankConcreteState.loading,
      ),
      const BankState(
        state: BankConcreteState.failure,
      ),
    ],
  );
  stateNotifierTest<BankNotifier, BankState>(
    'Should load list of banks on successful fetch',
    build: () => BankNotifier(bankRepository, bankCacheRepository),
    setUp: () {
      when(() => bankRepository.fetchBanks(skip: 0)).thenAnswer(
        (invocation) async => Right(ktestBankResponseModel),
      );
      when(() => bankCacheRepository.hasBank()).thenAnswer(
        (invocation) async => false,
      );
      when(() => bankCacheRepository.saveBank(bank: ktestBankResponseModel))
          .thenAnswer(
        (invocation) async => false,
      );
    },
    actions: (notifier) async {
      await notifier.fetchBanks();
    },
    expect: () => [
      const BankState(
        state: BankConcreteState.loading,
      ),
      BankState(
        state: BankConcreteState.loaded,
        hasData: true,
        productList: ktestBankResponseModel.records ?? [],
        page: 1,
        total: 100,
      ),
    ],
  );

  test('Should reset state to initial', () {
    notifier.resetState();

    // ignore: invalid_use_of_protected_member
    expect(notifier.state, const BankState.initial());
  });
}

class MockBankRepository extends Mock implements BankRepository {}

class MockBankCacheRepository extends Mock implements BankCacheRepository {}
