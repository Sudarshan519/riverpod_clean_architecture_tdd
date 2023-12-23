import 'package:khalti_task/shared/domain/models/paginated_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/bank/dummy_productlist.dart';
 
void main() {
  test('Should calculate the page from the response data', () {
    final PaginatedResponse paginatedResponse = ktestPaginatedResponse();

    expect(paginatedResponse.toString(),
        'PaginatedResponse(total:${paginatedResponse.total}, skip:${paginatedResponse.skip}, data:${paginatedResponse.data.length})');
  });
}
