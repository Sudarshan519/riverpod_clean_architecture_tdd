// ignore_for_file: public_member_api_docs

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_task/services/bank_cache_service/domain/providers/current_bank_provider.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';

final currentBankProvider = FutureProvider<BankResponseModel?>((ref) async {
  final repository = ref.watch(bankLocalRepositoryProvider);
  final eitherType = await repository.fetchBank();

  return eitherType.fold((l) => null, (r) => r);
});
