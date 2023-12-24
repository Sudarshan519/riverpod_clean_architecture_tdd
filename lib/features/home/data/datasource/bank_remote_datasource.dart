// ignore_for_file: one_member_abstracts, duplicate_ignore

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:khalti_task/shared/data/remote/remote.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

/// bank datasource
abstract class BankDatasource {
  /// fetch bank
  Future<Either<AppException, BankResponseModel>> fetchBanks({
    required int skip,
  });
}

/// bank datasource implementation
class BankRemoteDatasource extends BankDatasource {
  ///
  BankRemoteDatasource(this.networkService);

  /// network service
  final NetworkService networkService;

  @override
  Future<Either<AppException, BankResponseModel>> fetchBanks({
    required int skip,
  }) async {
    var deviceModel = 'unknown';
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        await deviceInfo.androidInfo.then((info) {
          deviceModel = info.model;
        });
      } else if (Platform.isIOS) {
        await deviceInfo.iosInfo.then((info) {
          deviceModel = info.model;
        });
      } else if (Platform.isLinux) {
        await deviceInfo.linuxInfo.then((info) {
          deviceModel = info.machineId ?? '';
        });
      } else {}
    } catch (e) {
      ///
    }
    networkService.updateHeader(
      {'DEVICE_MODEL': 'FLTASSIGN_sudarshan519_$deviceModel'},
    );
    final response = await networkService.get(
      '/bank',
      queryParameters: {},
    );

    return response.fold(
      Left.new,
      (r) {
        final jsonData = r.data as Map<String, dynamic>?;
        if (jsonData == null) {
          return Left(
            AppException(
              identifier: 'fetchBanks',
              statusCode: 0,
              message: 'The data is not in the valid format.',
            ),
          );
        }
        final paginatedResponse = BankResponseModel.fromJson(jsonData);
        return Right(paginatedResponse);
      },
    );
  }
}
