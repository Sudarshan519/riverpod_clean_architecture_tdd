import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:khalti_task/shared/data/local/storage_service.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';
import 'package:khalti_task/shared/globals.dart';

// ignore: public_member_api_docs
abstract class BankDataSource {
  ///
  String get storageKey;

  ///
  String get cachedDateTime;

  /// fetch bank
  Future<Either<AppException, BankResponseModel>> fetchBank();

  /// save bank
  Future<bool> saveBank({required BankResponseModel bank});

  /// check bank exist and is not expired
  Future<bool> hasBank();
}

/// local datasource implementation
class BankLocalDatasource extends BankDataSource {
  ///
  BankLocalDatasource(this.storageService);

  ///
  final StorageService storageService;

  @override
  String get storageKey => BANK_LOCAL_STORAGE_KEY;
  @override
  String get cachedDateTime => BANK_LOCAL_STORAGE_TIMESTAMP_KEY;

  @override
  Future<Either<AppException, BankResponseModel>> fetchBank() async {
    final data = await storageService.get(storageKey);

    if (data == null) {
      return Left(
        AppException(
          identifier: 'BankLocalDatasource',
          statusCode: 404,
          message: 'Try again later',
        ),
      );
    }
    final bankJson = jsonDecode(data.toString()) as Map<String, dynamic>?;

    return Right(BankResponseModel.fromJson(bankJson ?? {}));
  }

  @override
  Future<bool> saveBank({required BankResponseModel bank}) async {
    await storageService.set(
      cachedDateTime,
      DateTime.now().toString(),
    );
    // ignore: unnecessary_await_in_return
    return await storageService.set(storageKey, jsonEncode(bank.toJson()));
  }

  @override
  Future<bool> hasBank() async {
    final previousTimeStamp = DateTime.tryParse(
          (await storageService.get(cachedDateTime) ??
                  "${DateTime(0).toString()}")
              .toString(),
        ) ??
        DateTime(10);
    final differrence = DateTime.now().difference(previousTimeStamp);

    return differrence < const Duration(hours: 1);
  }
}
