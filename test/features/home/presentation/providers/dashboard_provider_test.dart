//test for filename
import 'package:dartz/dartz.dart';
import 'package:khalti_task/features/home/domain/repositories/bank_repository.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_notifier.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_state.dart';
import 'package:khalti_task/services/bank_cache_service/domain/repositories/bank_cache_repository.dart';
import 'package:khalti_task/shared/globals.dart';
import 'package:flutter_test/flutter_test.dart';
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
    },
    actions: (notifier) async {
      await notifier.fetchProducts();
    },
    expect: () => [
      const BankState(
        state: BankConcreteState.loading,
        page: 0,
        total: 0,
        hasData: false,
      ),
      const BankState(
        state: BankConcreteState.failure,
        productList: [],
        page: 0,
        total: 0,
        hasData: false,
      ),
    ],
  );
  stateNotifierTest<BankNotifier, BankState>(
    'Should load list of products on successful fetch',
    build: () => BankNotifier(bankRepository, bankCacheRepository),
    setUp: () {
      when(() => bankRepository.fetchBanks(skip: 0)).thenAnswer(
        (invocation) async => Right(ktestBankResponseModel),
      );
    },
    actions: (notifier) async {
      await notifier.fetchProducts();
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
  stateNotifierTest<BankNotifier, BankState>(
    'Should have productList of previous fetch when error occurs on second page',
    build: () => BankNotifier(bankRepository, bankCacheRepository),
    setUp: () {
      when(() => bankRepository.fetchBanks(skip: 0)).thenAnswer(
        (invocation) async => Right(ktestBankResponseModel),
      );
      when(() => bankRepository.fetchBanks(skip: PRODUCTS_PER_PAGE)).thenAnswer(
        (invocation) async => Left(ktestAppException),
      );
    },
    actions: (notifier) async {
      await notifier.fetchProducts();
      await notifier.fetchProducts();
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
      BankState(
        state: BankConcreteState.fetchingMore,
        hasData: true,
        productList: ktestBankResponseModel.records ?? [],
        page: 1,
        total: 100,
      ),
      BankState(
        state: BankConcreteState.failure,
        page: 1,
        total: 100,
        hasData: true,
        productList: ktestBankResponseModel.records ?? [],
      ),
    ],
  );

  stateNotifierTest<BankNotifier, BankState>(
    'Should increment page and append product response to the productList on successive fetch',
    build: () => BankNotifier(bankRepository, bankCacheRepository),
    setUp: () {
      when(() => bankRepository.fetchBanks(skip: 0)).thenAnswer(
        (invocation) async => Right(ktestBankResponseModel),
      );
      when(() => bankRepository.fetchBanks(skip: PRODUCTS_PER_PAGE)).thenAnswer(
        (invocation) async => Right(ktestBankResponseModel),
      );
    },
    actions: (notifier) async {
      await notifier.fetchProducts();
      await notifier.fetchProducts();
    },
    expect: () => [
      const BankState(
        state: BankConcreteState.loading,
        page: 0,
        total: 0,
        hasData: false,
      ),
      BankState(
        state: BankConcreteState.loaded,
        productList: ktestBankResponseModel.records ?? [],
        page: 1,
        total: 100,
        hasData: true,
      ),
      BankState(
        state: BankConcreteState.fetchingMore,
        hasData: true,
        page: 1,
        total: 100,
        productList: ktestBankResponseModel.records ?? [],
      ),
      BankState(
        state: BankConcreteState.loaded,
        productList: [...ktestBanklist, ...ktestBanklist],
        page: 2,
        total: 100,
        hasData: true,
      ),
    ],
  );
  group('home Search state', () {
    stateNotifierTest<BankNotifier, BankState>(
      'Should return empty [Records] when error occurs on search',
      build: () => BankNotifier(bankRepository, bankCacheRepository),
      setUp: () {
        when(() => bankRepository.searchBanks(skip: 0, query: '')).thenAnswer(
          (invocation) async => Left(ktestAppException),
        );
      },
      actions: (notifier) async {
        await notifier.searchBanks('');
      },
      expect: () => [
        const BankState(
          state: BankConcreteState.loading,
          page: 0,
          total: 0,
          hasData: false,
        ),
        const BankState(
          state: BankConcreteState.fetchedAllProducts,
          productList: [],
          page: 0,
          total: 0,
          hasData: false,
        ),
      ],
    );
    stateNotifierTest<BankNotifier, BankState>(
      'Should load list of products on successful fetch',
      build: () => BankNotifier(bankRepository, bankCacheRepository),
      setUp: () {
        when(() => bankRepository.searchBanks(skip: 0, query: '')).thenAnswer(
          (invocation) async => Right(ktestBankResponseModel),
        );
      },
      actions: (notifier) async {
        await notifier.searchBanks('');
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
    stateNotifierTest<BankNotifier, BankState>(
      'Should have productList of previous fetch when error occurs on second page',
      build: () => BankNotifier(bankRepository, bankCacheRepository),
      setUp: () {
        when(() => bankRepository.searchBanks(skip: 0, query: '')).thenAnswer(
          (invocation) async => Right(ktestBankResponseModel),
        );
        when(() =>
                bankRepository.searchBanks(skip: PRODUCTS_PER_PAGE, query: ''))
            .thenAnswer(
          (invocation) async => Left(ktestAppException),
        );
      },
      actions: (notifier) async {
        await notifier.searchBanks('');
        await notifier.searchBanks('');
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
        BankState(
          state: BankConcreteState.fetchingMore,
          hasData: true,
          productList: ktestBankResponseModel.records ?? [],
          page: 1,
          total: 100,
        ),
        BankState(
          state: BankConcreteState.failure,
          page: 1,
          total: 100,
          hasData: true,
          productList: ktestBankResponseModel.records ?? [],
        ),
      ],
    );

    stateNotifierTest<BankNotifier, BankState>(
      'Should increment page and append product response to the productList on successive fetch',
      build: () => BankNotifier(bankRepository, bankCacheRepository),
      setUp: () {
        when(() => bankRepository.searchBanks(skip: 0, query: '')).thenAnswer(
          (invocation) async => Right(ktestBankResponseModel),
        );
        when(() =>
                bankRepository.searchBanks(skip: PRODUCTS_PER_PAGE, query: ''))
            .thenAnswer(
          (invocation) async => Right(ktestBankResponseModel),
        );
      },
      actions: (notifier) async {
        await notifier.searchBanks('');
        await notifier.searchBanks('');
      },
      expect: () => [
        const BankState(
          state: BankConcreteState.loading,
          page: 0,
          total: 0,
          hasData: false,
        ),
        BankState(
          state: BankConcreteState.loaded,
          productList: ktestBankResponseModel.records ?? [],
          page: 1,
          total: 100,
          hasData: true,
        ),
        BankState(
          state: BankConcreteState.fetchingMore,
          hasData: true,
          page: 1,
          total: 100,
          productList: ktestBankResponseModel.records ?? [],
        ),
        BankState(
          state: BankConcreteState.loaded,
          productList: [...ktestBanklist, ...ktestBanklist],
          page: 2,
          total: 100,
          hasData: true,
        ),
      ],
    );
  });
  group('When the fetch is called while loading', () {
    stateNotifierTest<BankNotifier, BankState>(
      'Should not load list of products when it is already loading while search',
      build: () => BankNotifier(bankRepository, bankCacheRepository),
      setUp: () {
        when(() => bankRepository.searchBanks(skip: 0, query: '')).thenAnswer(
          (invocation) async => Right(ktestBankResponseModel),
        );
      },
      actions: (notifier) async {
        notifier.searchBanks('');
        notifier.searchBanks('');
      },
      expect: () => [
        const BankState(
          isLoading: true,
          productList: [],
          hasData: false,
          state: BankConcreteState.loading,
        ),
        const BankState(
          isLoading: false,
          productList: [],
          total: 0,
          page: 0,
          hasData: false,
          state: BankConcreteState.fetchedAllProducts,
          message: 'No more products available',
        ),
        BankState(
          isLoading: false,
          productList: ktestBankResponseModel.records ?? [],
          total: 100,
          page: 1,
          hasData: true,
          state: BankConcreteState.loaded,
        )
      ],
    );
    stateNotifierTest<BankNotifier, BankState>(
      'Should not load list of products when it is already loading while fetch',
      build: () => BankNotifier(bankRepository, bankCacheRepository),
      setUp: () {
        when(() => bankRepository.fetchBanks(skip: 0)).thenAnswer(
          (invocation) async => Right(ktestBankResponseModel),
        );
      },
      actions: (notifier) async {
        notifier.fetchProducts();
        notifier.fetchProducts();
      },
      expect: () => [
        const BankState(
          isLoading: true,
          productList: [],
          hasData: false,
          state: BankConcreteState.loading,
        ),
        const BankState(
          isLoading: false,
          productList: [],
          total: 0,
          page: 0,
          hasData: false,
          state: BankConcreteState.fetchedAllProducts,
          message: 'No more products available',
        ),
        BankState(
          isLoading: false,
          productList: ktestBankResponseModel.records ?? [],
          total: 100,
          page: 1,
          hasData: true,
          state: BankConcreteState.loaded,
        )
      ],
    );
  });
  test('Should reset state to initial', () {
    notifier.resetState();

    // ignore: invalid_use_of_protected_member
    expect(notifier.state, const BankState.initial());
  });
}

class MockBankRepository extends Mock implements BankRepository {}

class MockBankCacheRepository extends Mock implements BankCacheRepository {}
