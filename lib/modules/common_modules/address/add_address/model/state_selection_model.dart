class CountryStateModel {
  CountryStateModel({
    this.name,
    this.code,
    this.countryCode,
  });

  final String? name;
  final String? code;
  final String? countryCode;

  CountryStateModel copyWith({
    String? name,
    String? code,
    String? countryCode,
  }) {
    return CountryStateModel(
      name: name ?? this.name,
      code: code ?? this.code,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  factory CountryStateModel.fromJson(Map<String, dynamic> json) {
    return CountryStateModel(
      name: json["name"],
      code: json["code"],
      countryCode: json["country_code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "country_code": countryCode,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryStateModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code &&
          countryCode == other.countryCode;

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ countryCode.hashCode;
}
