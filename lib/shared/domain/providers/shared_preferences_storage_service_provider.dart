// ignore_for_file: public_member_api_docs, cascade_invocations

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_task/shared/data/local/shared_prefs_storage_service.dart';

final storageServiceProvider = Provider((ref) {
  final prefsService = SharedPrefsService();
  prefsService.init();
  return prefsService;
});
