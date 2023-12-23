import 'package:dartz/dartz.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

///
class Response {
  ///
  Response({
    required this.statusCode,
    this.statusMessage,
    // ignore: inference_failure_on_collection_literal
    this.data = const {},
  });

  ///
  final int statusCode;

  ///
  final String? statusMessage;

  ///
  final dynamic data;
  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }
}

///
extension ResponseExtension on Response {
  ///
  Right<AppException, Response> get toRight => Right(this);
}
