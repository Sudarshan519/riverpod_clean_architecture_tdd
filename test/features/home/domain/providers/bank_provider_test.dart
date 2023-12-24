import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:khalti_task/features/home/data/datasource/bank_remote_datasource.dart';
import 'package:khalti_task/features/home/domain/providers/bank_providers.dart';
import 'package:khalti_task/features/home/domain/repositories/bank_repository.dart';
import 'package:khalti_task/shared/data/remote/network_service.dart';
import 'package:khalti_task/shared/domain/providers/dio_network_service_provider.dart';

void main() {
  final providerContainer = ProviderContainer();
  late NetworkService networkService;
  late BankDatasource homeDataSource;
  late BankRepository bankRespository;
  setUpAll(
    () {
      networkService = providerContainer.read(networkServiceProvider);
      homeDataSource =
          providerContainer.read(bankDatasourceProvider(networkService));
      bankRespository = providerContainer.read(bankRepositoryProvider);
    },
  );
  test('homeDatasourceProvider is a homeDatasource', () {
    expect(
      homeDataSource,
      isA<BankDatasource>(),
    );
  });
  test('homeRepositoryProvider is a homeRepository', () {
    expect(
      bankRespository,
      isA<BankRepository>(),
    );
  });
  test('homeRepositoryProvider returns a homeRepository', () {
    expect(
      providerContainer.read(bankRepositoryProvider),
      isA<BankRepository>(),
    );
  });
}
