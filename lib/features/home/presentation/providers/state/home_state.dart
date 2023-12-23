// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';

enum BankConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchingMore,
  fetchedAllProducts
}

class BankState extends Equatable {
  final List<Records> productList;
  final int total;
  final int page;
  final bool hasData;
  final BankConcreteState state;
  final String message;
  final bool isLoading;
  const BankState({
    this.productList = const [],
    this.isLoading = false,
    this.hasData = false,
    this.state = BankConcreteState.initial,
    this.message = '',
    this.page = 0,
    this.total = 0,
  });

  const BankState.initial({
    this.productList = const [],
    this.total = 0,
    this.page = 0,
    this.isLoading = false,
    this.hasData = false,
    this.state = BankConcreteState.initial,
    this.message = '',
  });

  BankState copyWith({
    List<Records>? productList,
    int? total,
    int? page,
    bool? hasData,
    BankConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return BankState(
      isLoading: isLoading ?? this.isLoading,
      productList: productList ?? this.productList,
      total: total ?? this.total,
      page: page ?? this.page,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'homeState(isLoading:$isLoading, productLength: ${productList.length},total:$total page: $page, hasData: $hasData, state: $state, message: $message)';
  }

  @override
  List<Object?> get props => [productList, page, hasData, state, message];
}
