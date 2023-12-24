// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

void main() {
  final exception =
      AppException(message: 'message', statusCode: 1, identifier: 'identifier');
  test(
    'toString() function returns the objects',
    () {
      final expectedString =
          'statusCode=${exception.statusCode}\nmessage=${exception.message}\nidentifier=${exception.identifier}';

      final actual = exception.toString();

      expect(actual, expectedString);
    },
  );
}
