//
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_task/features/home/domain/providers/bank_providers.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_notifier.dart';
import 'package:khalti_task/features/home/presentation/providers/state/home_state.dart';
import 'package:khalti_task/services/bank_cache_service/domain/providers/current_bank_provider.dart';

/// provider instance
final bankNotifierProvider =
    StateNotifierProvider<BankNotifier, BankState>((ref) {
  final repository = ref.watch(bankRepositoryProvider);
  final cacheRepository = ref.watch(bankLocalRepositoryProvider);
  return BankNotifier(repository, cacheRepository)..fetchBanks();
});
