import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:khalti_task/features/home/domain/repositories/bank_repository.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_state.dart';
import 'package:khalti_task/services/bank_cache_service/domain/repositories/bank_cache_repository.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';
import 'package:khalti_task/shared/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BankNotifier extends StateNotifier<BankState> {
  final BankRepository bankRepository;
  final BankCacheRepository bankCacheRepository;

  BankNotifier(
    this.bankRepository,
    this.bankCacheRepository,
  ) : super(const BankState.initial());

  ///
  BankResponseModel? memoryCachedData;

  ///
  var cachedTime = 0;

  ///
  var expiryMillisecond = const Duration(hours: 1).inMilliseconds;

  ///
  int elapsedDurationInMilliseconds(current, previous) => current - previous;

  ///
  bool isExpired(currentMillisecondEpoach) =>
      currentMillisecondEpoach < expiryMillisecond;

  ///
  bool get isFetching =>
      state.state != BankConcreteState.loading &&
      state.state != BankConcreteState.fetchingMore;

  Future<void> fetchProducts() async {
    /// check if data is expired and not empty
    print(await bankCacheRepository.hasBank());
    if (await bankCacheRepository.hasBank()) {
      var cachedData = await bankCacheRepository.fetchBank();
      print(cachedData);
      updateStateFromResponse(cachedData);
    } else if (isFetching &&
        state.state != BankConcreteState.fetchedAllProducts) {
      state = state.copyWith(
        state: state.page > 0
            ? BankConcreteState.fetchingMore
            : BankConcreteState.loading,
        isLoading: true,
      );

      final response =
          await bankRepository.fetchBanks(skip: state.page * PRODUCTS_PER_PAGE);

      updateStateFromResponse(response);
    }
  }

  ///
  Future<void> searchBanks(String query) async {
    final matchingData = <Records>[];
    if (query.isEmpty) {
      state = state.copyWith(productList: memoryCachedData?.records ?? []);
    }

    /// loop data items
    for (final item in state.productList) {
      /// filter [Record] Name and address
      if ((item.name ?? '').toLowerCase().contains(query.toLowerCase()) ||
          (item.address ?? '').toLowerCase().contains(query.toLowerCase())) {
        matchingData.add(item);
      }
      state = state.copyWith(productList: matchingData);
      // if (isFetching && state.state != BankConcreteState.fetchedAllProducts) {
      //   state = state.copyWith(
      //     state: state.page > 0
      //         ? BankConcreteState.fetchingMore
      //         : BankConcreteState.loading,
      //     isLoading: true,
      //   );

      //   final response = await bankRepository.searchBank(
      //     skip: state.page * PRODUCTS_PER_PAGE,
      //     query: query,
      //   );

      //   updateStateFromResponse(response);
      // } else {
      //   state = state.copyWith(
      //     state: BankConcreteState.fetchedAllProducts,
      //     message: 'No more products available',
      //     isLoading: false,
      //   );
      // }
    }
  }

  void updateStateFromResponse(
      Either<AppException, BankResponseModel> response) {
    response.fold((failure) {
      state = state.copyWith(
        state: BankConcreteState.failure,
        message: failure.message,
        isLoading: false,
      );
    }, (data) {
      final productList = data.records ?? [];
      memoryCachedData = data;
      bankCacheRepository.saveBank(bank: data);
      cachedTime = DateTime.now().millisecondsSinceEpoch;
      final totalProducts = <Records>[...state.productList, ...productList];

      state = state.copyWith(
        productList: totalProducts,
        state: totalProducts.length == data.total_records
            ? BankConcreteState.fetchedAllProducts
            : BankConcreteState.loaded,
        hasData: true,
        message: totalProducts.isEmpty ? 'No bank found' : '',
        page: totalProducts.length ~/ PRODUCTS_PER_PAGE,
        total: data.total_pages,
        isLoading: false,
      );
    });
  }

  void resetState() {
    state = const BankState.initial();
  }
}
