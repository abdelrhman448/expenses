import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  CurrencyModel({
    required this.result,
    required this.provider,
    required this.documentation,
    required this.termsOfUse,
    required this.timeLastUpdateUnix,
    required this.timeLastUpdateUtc,
    required this.timeNextUpdateUnix,
    required this.timeNextUpdateUtc,
    required this.timeEolUnix,
    required this.baseCode,
    required this.rates,
  });

  final String? result;
  final String? provider;
  final String? documentation;
  final String? termsOfUse;
  final int? timeLastUpdateUnix;
  final String? timeLastUpdateUtc;
  final int? timeNextUpdateUnix;
  final String? timeNextUpdateUtc;
  final int? timeEolUnix;
  final String? baseCode;
  final Map<String, double> rates;

  factory CurrencyModel.fromJson(Map<String, dynamic> json){
    return CurrencyModel(
      result: json["result"],
      provider: json["provider"],
      documentation: json["documentation"],
      termsOfUse: json["terms_of_use"],
      timeLastUpdateUnix: json["time_last_update_unix"],
      timeLastUpdateUtc: json["time_last_update_utc"],
      timeNextUpdateUnix: json["time_next_update_unix"],
      timeNextUpdateUtc: json["time_next_update_utc"],
      timeEolUnix: json["time_eol_unix"],
      baseCode: json["base_code"],
      rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v)),
    );
  }

  @override
  List<Object?> get props => [
    result, provider, documentation, termsOfUse, timeLastUpdateUnix, timeLastUpdateUtc, timeNextUpdateUnix, timeNextUpdateUtc, timeEolUnix, baseCode, rates, ];
}
