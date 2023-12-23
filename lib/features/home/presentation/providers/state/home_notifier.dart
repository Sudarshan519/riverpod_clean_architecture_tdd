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
  int cachedTime = 0;

  ///
  int expiryMillisecond = const Duration(hours: 1).inMilliseconds;

  ///
  int elapsedDurationInMilliseconds(int current, int previous) =>
      current - previous;

  ///
  bool isExpired(int currentMillisecondEpoach) =>
      currentMillisecondEpoach < expiryMillisecond;

  ///
  bool get isFetching =>
      state.state != BankConcreteState.loading &&
      state.state != BankConcreteState.fetchingMore;

  /// fetch
  Future<void> fetchBanks() async {
    /// check if data is expired and not empty
    ///
    var hasBankData = await bankCacheRepository.hasBank();
    if (state.state != BankConcreteState.loaded) {
      state = state.copyWith(
        state: state.page > 0
            ? BankConcreteState.fetchingMore
            : BankConcreteState.loading,
        isLoading: true,
      );

      if (hasBankData) {
        final cachedData = await bankCacheRepository.fetchBank();

        updateStateFromResponse(cachedData, saveData: true);
      } else {
        final response = await bankRepository.fetchBanks(
          skip: 0,
        );

        updateStateFromResponse(response, saveData: true);
      }
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
    }
  }

  /// update state
  ///
  void updateStateFromResponse(
    Either<AppException, BankResponseModel> response, {
    bool saveData = false,
  }) {
    response.fold((failure) {
      state = state.copyWith(
        state: BankConcreteState.failure,
        message: failure.message,
        isLoading: false,
      );
    }, (data) {
      final productList = data.records ?? [];
      memoryCachedData = data;
      print(data);
      if (saveData) bankCacheRepository.saveBank(bank: data);
      cachedTime = DateTime.now().millisecondsSinceEpoch;
      final totalProducts = <Records>[...state.productList, ...productList];

      state = state.copyWith(
        productList: totalProducts,
        state: totalProducts.length == data.total_records
            ? BankConcreteState.loaded
            : BankConcreteState.loaded,
        hasData: true,
        message: totalProducts.isEmpty ? 'No bank found' : '',
        page: totalProducts.length ~/ PRODUCTS_PER_PAGE,
        total: data.total_pages,
        isLoading: false,
      );
    });
  }

  /// reset state
  void resetState() {
    state = const BankState.initial();
  }
}
