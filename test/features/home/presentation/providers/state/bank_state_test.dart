// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_state.dart';

void main() {
  group('homeState Test\n', () {
    test('Should update concrete state', () {
      var homeState = const BankState();

      homeState = homeState.copyWith(message: 'homeConcreteState.loading');

      expect(homeState.message, equals('homeConcreteState.loading'));
    });
    test('Should return valid String', () {
      const homeState = BankState();

      expect(
        homeState.toString(),
        'homeState(isLoading:${homeState.isLoading}, productLength: ${homeState.banklist.length},total:${homeState.total} page: ${homeState.page}, hasData: ${homeState.hasData}, state: ${homeState.state}, message: ${homeState.message})',
      );
    });
  });
}
