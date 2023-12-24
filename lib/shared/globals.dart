// ignore_for_file: public_member_api_docs, constant_identifier_names

import 'dart:io';

final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');
const int PRODUCTS_PER_PAGE = 20;
const String USER_LOCAL_STORAGE_KEY = 'user';
const String BANK_LOCAL_STORAGE_KEY = 'bank';
const String APP_THEME_STORAGE_KEY = 'AppTheme';
const String BANK_LOCAL_STORAGE_TIMESTAMP_KEY = 'timestamp';
