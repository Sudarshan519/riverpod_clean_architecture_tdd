import 'package:khalti_task/services/user_cache_service/data/datasource/user_local_datasource.dart';
import 'package:khalti_task/services/user_cache_service/data/repositories/user_repository_impl.dart';
import 'package:khalti_task/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:khalti_task/shared/data/local/storage_service.dart';
import 'package:khalti_task/shared/domain/providers/shared_preferences_storage_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDatasourceProvider = Provider.family<UserDataSource, StorageService>(
  (_, networkService) => UserLocalDatasource(networkService),
);

final userLocalRepositoryProvider = Provider<UserRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);

  final datasource = ref.watch(userDatasourceProvider(storageService));

  final repository = UserRepositoryImpl(datasource);

  return repository;
});
