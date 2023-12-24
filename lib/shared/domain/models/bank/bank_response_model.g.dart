// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'bank_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BankResponse _$$_BankResponseFromJson(Map<String, dynamic> json) =>
    _$_BankResponse(
      total_pages: json['total_pages'] as int?,
      total_records: json['total_records'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      record_range: (json['record_range'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      current_page: json['current_page'] as int?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => Records.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_BankResponseToJson(_$_BankResponse instance) =>
    <String, dynamic>{
      'total_pages': instance.total_pages,
      'total_records': instance.total_records,
      'next': instance.next,
      'previous': instance.previous,
      'record_range': instance.record_range,
      'current_page': instance.current_page,
      'records': instance.records,
    };
