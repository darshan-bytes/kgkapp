class CscDetails {
  CscDetails({
    required this.id,
    required this.cscCode,
    required this.cscName,
    required this.countryCode,
    required this.countryName,
    required this.subareaCode,
  });

  final String? id;
  final String? cscCode;
  final String? cscName;
  final String? countryCode;
  final String? countryName;
  final String? subareaCode;

  CscDetails copyWith({
    String? id,
    String? cscCode,
    String? cscName,
    String? countryCode,
    String? countryName,
    String? subareaCode,
  }) {
    return CscDetails(
      id: id ?? this.id,
      cscCode: cscCode ?? this.cscCode,
      cscName: cscName ?? this.cscName,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      subareaCode: subareaCode ?? this.subareaCode,
    );
  }

  factory CscDetails.fromJson(Map<String, dynamic> json) {
    return CscDetails(
      id: json["id"],
      cscCode: json["csc_code"],
      cscName: json["csc_name"],
      countryCode: json["country_code"],
      countryName: json["country_name"],
      subareaCode: json["subarea_code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "csc_code": cscCode,
        "csc_name": cscName,
        "country_code": countryCode,
        "country_name": countryName,
        "subarea_code": subareaCode,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CscDetails &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          cscCode == other.cscCode &&
          cscName == other.cscName &&
          countryCode == other.countryCode &&
          countryName == other.countryName &&
          subareaCode == other.subareaCode;

  @override
  int get hashCode =>
      id.hashCode ^ cscCode.hashCode ^ cscName.hashCode ^ countryCode.hashCode ^ countryName.hashCode ^ subareaCode.hashCode;
}
