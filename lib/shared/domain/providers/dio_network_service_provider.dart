// ignore_for_file: public_member_api_docs

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_task/shared/data/remote/dio_network_service.dart';

final networkServiceProvider = Provider<DioNetworkService>(
  (ref) {
    final dio = Dio();
    return DioNetworkService(dio);
  },
);
