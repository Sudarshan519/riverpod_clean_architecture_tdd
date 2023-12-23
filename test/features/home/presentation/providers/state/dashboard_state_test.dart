import 'package:flutter_test/flutter_test.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_state.dart';

void main() {
  group('homeState Test\n', () {
    test('Should update concrete state', () {
      BankState homeState = const BankState();

      homeState = homeState.copyWith(message: 'homeConcreteState.loading');

      expect(homeState.message, equals('homeConcreteState.loading'));
    });
    test('Should return valid String', () {
      BankState homeState = const BankState();

      expect(
        homeState.toString(),
        'homeState(isLoading:${homeState.isLoading}, productLength: ${homeState.productList.length},total:${homeState.total} page: ${homeState.page}, hasData: ${homeState.hasData}, state: ${homeState.state}, message: ${homeState.message})',
      );
    });
  });
}
