import 'package:flutter_test/flutter_test.dart';
import 'package:khalti_task/shared/domain/models/bank/bank_response_model.dart';

import '../../../../fixtures/bank/dummy_banklist.dart';

void main() {
  group(
    'ProductModel Test\n',
    () {
      test('Should parse BankResponeModel from json', () {
        expect(BankResponseModel.fromJson(ktestBankResponse),
            isA<BankResponseModel>(),);
      });

      test('Should return json from model', () {
        expect(ktestBankResponseModel.toJson(), isA<Map<String, dynamic>>());
      });
     
    },
  );
}
