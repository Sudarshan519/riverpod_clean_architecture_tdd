import 'package:dartz/dartz.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

abstract class BankRepository {
  Future<Either<AppException, BankResponseModel>> fetchBanks(
      {required int skip});
  Future<Either<AppException, BankResponseModel>> searchBanks(
      {required int skip, required String query});
}