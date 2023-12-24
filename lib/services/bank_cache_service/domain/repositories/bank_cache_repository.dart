// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

abstract class BankCacheRepository {
  Future<Either<AppException, BankResponseModel>> fetchBank();
  Future<bool> saveBank({required BankResponseModel bank});

  Future<bool> hasBank();
}
