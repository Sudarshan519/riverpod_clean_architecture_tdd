// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BankResponseModel _$BankResponseModelFromJson(Map<String, dynamic> json) {
  return _BankResponse.fromJson(json);
}

/// @nodoc
mixin _$BankResponseModel {
  /// total pages
  int? get total_pages => throw _privateConstructorUsedError;

  /// total records
  int? get total_records => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<int>? get record_range => throw _privateConstructorUsedError;
  int? get current_page => throw _privateConstructorUsedError;
  List<Records>? get records => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BankResponseModelCopyWith<BankResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankResponseModelCopyWith<$Res> {
  factory $BankResponseModelCopyWith(
          BankResponseModel value, $Res Function(BankResponseModel) then) =
      _$BankResponseModelCopyWithImpl<$Res, BankResponseModel>;
  @useResult
  $Res call(
      {int? total_pages,
      int? total_records,
      String? next,
      String? previous,
      List<int>? record_range,
      int? current_page,
      List<Records>? records});
}

/// @nodoc
class _$BankResponseModelCopyWithImpl<$Res, $Val extends BankResponseModel>
    implements $BankResponseModelCopyWith<$Res> {
  _$BankResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total_pages = freezed,
    Object? total_records = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? record_range = freezed,
    Object? current_page = freezed,
    Object? records = freezed,
  }) {
    return _then(_value.copyWith(
      total_pages: freezed == total_pages
          ? _value.total_pages
          : total_pages // ignore: cast_nullable_to_non_nullable
              as int?,
      total_records: freezed == total_records
          ? _value.total_records
          : total_records // ignore: cast_nullable_to_non_nullable
              as int?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      record_range: freezed == record_range
          ? _value.record_range
          : record_range // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      current_page: freezed == current_page
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int?,
      records: freezed == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<Records>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BankResponseCopyWith<$Res>
    implements $BankResponseModelCopyWith<$Res> {
  factory _$$_BankResponseCopyWith(
          _$_BankResponse value, $Res Function(_$_BankResponse) then) =
      __$$_BankResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? total_pages,
      int? total_records,
      String? next,
      String? previous,
      List<int>? record_range,
      int? current_page,
      List<Records>? records});
}

/// @nodoc
class __$$_BankResponseCopyWithImpl<$Res>
    extends _$BankResponseModelCopyWithImpl<$Res, _$_BankResponse>
    implements _$$_BankResponseCopyWith<$Res> {
  __$$_BankResponseCopyWithImpl(
      _$_BankResponse _value, $Res Function(_$_BankResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total_pages = freezed,
    Object? total_records = freezed,
    Object? next = freezed,
    Object? previous = freezed,
    Object? record_range = freezed,
    Object? current_page = freezed,
    Object? records = freezed,
  }) {
    return _then(_$_BankResponse(
      total_pages: freezed == total_pages
          ? _value.total_pages
          : total_pages // ignore: cast_nullable_to_non_nullable
              as int?,
      total_records: freezed == total_records
          ? _value.total_records
          : total_records // ignore: cast_nullable_to_non_nullable
              as int?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      record_range: freezed == record_range
          ? _value._record_range
          : record_range // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      current_page: freezed == current_page
          ? _value.current_page
          : current_page // ignore: cast_nullable_to_non_nullable
              as int?,
      records: freezed == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<Records>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BankResponse implements _BankResponse {
  _$_BankResponse(
      {this.total_pages,
      this.total_records,
      this.next,
      this.previous,
      final List<int>? record_range,
      this.current_page,
      final List<Records>? records})
      : _record_range = record_range,
        _records = records;

  factory _$_BankResponse.fromJson(Map<String, dynamic> json) =>
      _$$_BankResponseFromJson(json);

  /// total pages
  @override
  final int? total_pages;

  /// total records
  @override
  final int? total_records;
  @override
  final String? next;
  @override
  final String? previous;
  final List<int>? _record_range;
  @override
  List<int>? get record_range {
    final value = _record_range;
    if (value == null) return null;
    if (_record_range is EqualUnmodifiableListView) return _record_range;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? current_page;
  final List<Records>? _records;
  @override
  List<Records>? get records {
    final value = _records;
    if (value == null) return null;
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BankResponseModel(total_pages: $total_pages, total_records: $total_records, next: $next, previous: $previous, record_range: $record_range, current_page: $current_page, records: $records)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BankResponse &&
            (identical(other.total_pages, total_pages) ||
                other.total_pages == total_pages) &&
            (identical(other.total_records, total_records) ||
                other.total_records == total_records) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous) &&
            const DeepCollectionEquality()
                .equals(other._record_range, _record_range) &&
            (identical(other.current_page, current_page) ||
                other.current_page == current_page) &&
            const DeepCollectionEquality().equals(other._records, _records));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      total_pages,
      total_records,
      next,
      previous,
      const DeepCollectionEquality().hash(_record_range),
      current_page,
      const DeepCollectionEquality().hash(_records));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BankResponseCopyWith<_$_BankResponse> get copyWith =>
      __$$_BankResponseCopyWithImpl<_$_BankResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BankResponseToJson(
      this,
    );
  }
}

abstract class _BankResponse implements BankResponseModel {
  factory _BankResponse(
      {final int? total_pages,
      final int? total_records,
      final String? next,
      final String? previous,
      final List<int>? record_range,
      final int? current_page,
      final List<Records>? records}) = _$_BankResponse;

  factory _BankResponse.fromJson(Map<String, dynamic> json) =
      _$_BankResponse.fromJson;

  @override

  /// total pages
  int? get total_pages;
  @override

  /// total records
  int? get total_records;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<int>? get record_range;
  @override
  int? get current_page;
  @override
  List<Records>? get records;
  @override
  @JsonKey(ignore: true)
  _$$_BankResponseCopyWith<_$_BankResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
