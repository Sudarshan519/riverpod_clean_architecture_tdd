import 'package:dartz/dartz.dart';
import 'package:khalti_task/shared/data/remote/remote.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

abstract class BankDatasource {
  Future<Either<AppException, BankResponseModel>> fetchBanks(
      {required int skip});
  Future<Either<AppException, BankResponseModel>> searchBanks(
      {required int skip, required String query});
}

class BankRemoteDatasource extends BankDatasource {
  final NetworkService networkService;
  BankRemoteDatasource(this.networkService);

  @override
  Future<Either<AppException, BankResponseModel>> fetchBanks(
      {required int skip}) async {
    final response = await networkService.get(
      '/bank',
      queryParameters: {},
    );

    return response.fold(
      (l) => Left(l),
      (r) {
        final jsonData = r.data;
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

  @override
  Future<Either<AppException, BankResponseModel>> searchBanks(
      {required int skip, required String query}) {
    // TODO: implement searchBanks
    throw UnimplementedError();
  }
}
