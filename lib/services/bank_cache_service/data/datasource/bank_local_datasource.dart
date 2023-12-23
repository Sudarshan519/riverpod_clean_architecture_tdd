import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:khalti_task/shared/data/local/storage_service.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';
import 'package:khalti_task/shared/globals.dart';

abstract class BankDataSource {
  String get storageKey;
  String get cachedTimeInMilliseconds;

  Future<Either<AppException, BankResponseModel>> fetchBank();
  Future<bool> saveBank({required BankResponseModel bank});
  Future<bool> hasBank();
}

class BankLocalDatasource extends BankDataSource {
  BankLocalDatasource(this.storageService);

  final StorageService storageService;

  ///
  var cachedTime = 0;

  ///
  var expiryMillisecond = const Duration(hours: 1).inMilliseconds;

  ///
  int elapsedDurationInMilliseconds(current, previous) => current - previous;

  ///
  bool isExpired(currentMillisecondEpoach) =>
      currentMillisecondEpoach < expiryMillisecond;

  @override
  String get storageKey => USER_LOCAL_STORAGE_KEY;
  @override
  String get cachedTimeInMilliseconds => BANK_LOCAL_STORAGE_TIMESTAMP_KEY;

  @override
  Future<Either<AppException, BankResponseModel>> fetchBank() async {
    final data = await storageService.get(storageKey);
    if (data == null) {
      return Left(
        AppException(
          identifier: 'BankLocalDatasource',
          statusCode: 404,
          message: 'Bank not found',
        ),
      );
    }
    final bankJson = jsonDecode(data.toString());

    return Right(BankResponseModel.fromJson(bankJson));
  }

  @override
  Future<bool> saveBank({required BankResponseModel bank}) async {
    await storageService.set(cachedTimeInMilliseconds,
        jsonEncode(DateTime.now().millisecondsSinceEpoch.toString()));

    return await storageService.set(storageKey, jsonEncode(bank.toJson()));
  }

  @override
  Future<bool> hasBank() async {
    final cachedMilliseconds =
        await storageService.get(cachedTimeInMilliseconds) ?? '0';

    final previousTimeStamp = int.parse(cachedMilliseconds.toString());
    final now = DateTime.now().millisecondsSinceEpoch;
    final differrence = now - previousTimeStamp;
    return (differrence < const Duration(hours: 1).inMilliseconds);
  }
}
