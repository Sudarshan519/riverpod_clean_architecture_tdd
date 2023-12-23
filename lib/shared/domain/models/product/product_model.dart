import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

typedef ProductList = List<Product>;

@freezed
class Product with _$Product {
  factory Product({
    required int id,
    required String title,
    required String description,
    required String thumbnail,
    String? brand,
    String? category,
    double? rating,
    double? discountPercentage,
    int? stock,
    int? price,
    List<String>? images,
  }) = _Product;

  factory Product.fromJson(dynamic json) => _$ProductFromJson(json);
}
