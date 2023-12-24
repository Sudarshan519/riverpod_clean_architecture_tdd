// ignore_for_file: public_member_api_docs

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_task/services/bank_cache_service/data/datasource/bank_local_datasource.dart';
import 'package:khalti_task/services/bank_cache_service/data/repositories/bank_repository_impl.dart';
import 'package:khalti_task/services/bank_cache_service/domain/repositories/bank_cache_repository.dart';
import 'package:khalti_task/shared/data/local/storage_service.dart';
import 'package:khalti_task/shared/domain/providers/shared_preferences_storage_service_provider.dart';

final bankDatasourceProvider = Provider.family<BankDataSource, StorageService>(
  (_, networkService) => BankLocalDatasource(networkService),
);

final bankLocalRepositoryProvider = Provider<BankCacheRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);

  final datasource = ref.watch(bankDatasourceProvider(storageService));

  final repository = BankCacheRepositoryImpl(datasource);

  return repository;
});
