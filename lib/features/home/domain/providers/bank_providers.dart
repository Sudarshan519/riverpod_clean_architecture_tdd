// ignore_for_file: public_member_api_docs

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_task/features/home/data/datasource/bank_remote_datasource.dart';
import 'package:khalti_task/features/home/data/repositories/bank_repository.dart';
import 'package:khalti_task/features/home/domain/repositories/bank_repository.dart';
import 'package:khalti_task/shared/data/remote/network_service.dart';
import 'package:khalti_task/shared/domain/providers/dio_network_service_provider.dart';

final bankDatasourceProvider = Provider.family<BankDatasource, NetworkService>(
  (_, networkService) => BankRemoteDatasource(networkService),
);

final bankRepositoryProvider = Provider<BankRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(bankDatasourceProvider(networkService));
  final repository = BankRepositoryImpl(datasource);

  return repository;
});
