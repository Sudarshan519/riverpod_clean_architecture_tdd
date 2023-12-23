// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_response_model.freezed.dart';
part 'bank_response_model.g.dart';

/// Bank Response
@freezed
class BankResponseModel with _$BankResponseModel {
  /// Constructor for response model
  factory BankResponseModel({
    /// total pages
    int? total_pages,

    /// total records
    int? total_records,
    String? next,
    String? previous,
    List<int>? record_range,
    int? current_page,
    List<Records>? records,
  }) = _BankResponse;

  /// Convert a JSON object into an [BankResponseModel] instance.
  /// This enables type-safe reading of the API response.
  factory BankResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BankResponseModelFromJson(json);
}

/// records model class

class Records {
  /// records model constructor
  Records({
    this.idx,
    this.name,
    this.shortName,
    this.logo,
    this.swiftCode,
    this.hasCardpayment,
    this.address,
    this.ebankingUrl,
    this.hasEbanking,
    this.hasMobileCheckout,
    this.hasDirectWithdraw,
    this.hasNchl,
    this.hasMobileBanking,
    this.playStore,
    this.appStore,
    this.branches,
  });

  /// records model from jjon
  Records.fromJson(Map<String, dynamic> json) {
    idx = json['idx'] as String;
    name = json['name'] as String;
    shortName = json['short_name'] as String;
    logo = json['logo'] as String?;
    swiftCode = json['swift_code'] as String;
    hasCardpayment = json['has_cardpayment'] as bool;
    address = json['address'] as String;
    ebankingUrl = json['ebanking_url'] as String;
    hasEbanking = json['has_ebanking'] as bool?;
    hasMobileCheckout = json['has_mobile_checkout'] as bool?;
    hasDirectWithdraw = json['has_direct_withdraw'] as bool?;
    hasNchl = json['has_nchl'] as bool?;
    hasMobileBanking = json['has_mobile_banking'] as bool?;
    playStore = json['play_store'] as String;
    appStore = json['app_store'] as String;
  }

  /// index
  String? idx;

  /// name
  String? name;

  /// short name
  String? shortName;

  /// logo
  String? logo;

  /// swift code
  String? swiftCode;

  ///boolean varibale check if has card payment
  bool? hasCardpayment;

  /// optional address
  String? address;

  /// ebanking url
  String? ebankingUrl;

  /// boolean varialbe to check if have ebanking
  bool? hasEbanking;

  /// boolean variable to check if has mobile checkout
  bool? hasMobileCheckout;

  /// boolean variable to check if has direct withdraw
  bool? hasDirectWithdraw;

  /// boolean variable to check if has nchl
  bool? hasNchl;

  /// boolean variable check if has mobile banking
  bool? hasMobileBanking;

  /// varibale play store url
  String? playStore;

  /// varibale app store url
  String? appStore;

  /// list of branches
  List<String>? branches;

  /// records to json
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['idx'] = idx;
    data['name'] = name;
    data['short_name'] = shortName;
    data['logo'] = logo;
    data['swift_code'] = swiftCode;
    data['has_cardpayment'] = hasCardpayment;
    data['address'] = address;
    data['ebanking_url'] = ebankingUrl;
    data['has_ebanking'] = hasEbanking;
    data['has_mobile_checkout'] = hasMobileCheckout;
    data['has_direct_withdraw'] = hasDirectWithdraw;
    data['has_nchl'] = hasNchl;
    data['has_mobile_banking'] = hasMobileBanking;
    data['play_store'] = playStore;
    data['app_store'] = appStore;

    return data;
  }
}
