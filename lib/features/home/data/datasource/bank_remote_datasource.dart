import 'package:dartz/dartz.dart';
import 'package:khalti_task/shared/data/remote/remote.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

// ignore: one_member_abstracts
/// bank datasource
abstract class BankDatasource {
  /// fetch bank
  Future<Either<AppException, BankResponseModel>> fetchBanks(
      {required int skip,});
 
}

/// bank datasource implementation
class BankRemoteDatasource extends BankDatasource {
  ///
  BankRemoteDatasource(this.networkService);

  /// network service
  final NetworkService networkService;

  @override
  Future<Either<AppException, BankResponseModel>> fetchBanks(
      {required int skip,}) async {
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
