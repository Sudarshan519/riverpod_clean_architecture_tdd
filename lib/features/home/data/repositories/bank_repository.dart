import 'package:dartz/dartz.dart';
import 'package:khalti_task/features/home/data/datasource/bank_remote_datasource.dart';
import 'package:khalti_task/features/home/domain/repositories/bank_repository.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

///
class BankRepositoryImpl extends BankRepository {
  ///
  BankRepositoryImpl(this.bankDatasource);

  ///
  final BankDatasource bankDatasource;

  @override
  Future<Either<AppException, BankResponseModel>> fetchBanks(
      {required int skip,}) {
    return bankDatasource.fetchBanks(skip: skip);
  }
}
