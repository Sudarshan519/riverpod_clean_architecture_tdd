import 'package:dartz/dartz.dart';
import 'package:khalti_task/services/bank_cache_service/data/datasource/bank_local_datasource.dart';
import 'package:khalti_task/services/bank_cache_service/domain/repositories/bank_cache_repository.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';

import 'package:khalti_task/shared/exceptions/http_exception.dart';

class BankCacheRepositoryImpl extends BankCacheRepository {
  BankCacheRepositoryImpl(this.dataSource);

  final BankDataSource dataSource;

  @override
  Future<Either<AppException, BankResponseModel>> fetchBank() {
    return dataSource.fetchBank();
  }

  @override
  Future<bool> saveBank({required BankResponseModel bank}) {
    return dataSource.saveBank(bank: bank);
  }

  @override
  Future<bool> hasBank() {
    return dataSource.hasBank();
  }
}
