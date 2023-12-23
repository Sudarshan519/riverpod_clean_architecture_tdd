// ignore_for_file: inference_failure_on_collection_literal

import 'package:khalti_task/shared/domain/models/response.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

final AppException ktestAppException =
    AppException(message: '', statusCode: 0, identifier: '');

final Response ktestUserResponse =
    Response(statusMessage: 'message', statusCode: 1, data: {});
