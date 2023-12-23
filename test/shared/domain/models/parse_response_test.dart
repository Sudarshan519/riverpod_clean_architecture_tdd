import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';
import 'package:khalti_task/shared/domain/models/parse_response.dart'; 
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/bank/dummy_banklist.dart';

void main() {
  test('Should parse response in correct format', () {
    final response = ParseResponse<Records>.fromMap(
        ktestBankResponse['records'][0],
        modifier: Records.fromJson);

    expect(response.data is Records, true);
  });
}
