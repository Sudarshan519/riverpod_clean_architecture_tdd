import 'package:khalti_task/shared/domain/models/product/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/bank/dummy_banklist.dart';
import '../../../../fixtures/bank/dummy_productlist.dart';
import '../../../../fixtures/data/product_response.dart';

void main() {
  group(
    'ProductModel Test\n',
    () {
      test('Should parse Product from json', () {
        expect(Product.fromJson(productMap), ktestBankResponse[0]);
      });

      test('Should return json from product', () {
        expect(ktestProductList[0].toJson(), productMap);
      });
      test('Should return string of user', () {
        expect(ktestProductList[0].toJson(), isA<Map<String, dynamic>>());
      });
    },
  );
}
