 

import 'package:khalti_task/shared/domain/models/response.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

import 'data/user_map.dart';

final AppException ktestAppException =
    AppException(message: '', statusCode: 0, identifier: '');

 

final Response ktestUserResponse =
    Response(statusMessage: 'message', statusCode: 1, data: {});
