// To parse this JSON data, do
//
//     final parseResponse = parseResponseFromMap(jsonString);
///
class ParseResponse<T> {
  ///
  ParseResponse({
    this.status,
    this.message,
    this.data,
    this.success = false,
  });

  ///
  final bool success;

  ///
  final String? status;

  ///
  final String? message;

  ///
  final T? data;

  ///
  factory ParseResponse.fromMap(dynamic json,
      {required T Function(Map<String, dynamic>) modifier}) {
    return ParseResponse<T>(
      data: modifier(json as Map<String, dynamic>),
    );
  }
}
