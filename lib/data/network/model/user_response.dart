class UserResponse {
  String? vUserUuid;
  String? vName;
  String? vEmailId;
  String? vISDCode;
  String? vMobileNumber;
  int? tiIsSocialLogin;
  String? vProfilePic;
  String? vAccessToken;

  UserResponse(
      {this.vUserUuid,
      this.vName,
      this.vEmailId,
      this.vISDCode,
      this.vMobileNumber,
      this.tiIsSocialLogin,
      this.vProfilePic,
      this.vAccessToken});

  UserResponse.fromJson(Map<String, dynamic> json) {
    vUserUuid = json['vUserUuid'];
    vName = json['vName'];
    vEmailId = json['vEmailId'];
    vISDCode = json['vISDCode'];
    vMobileNumber = json['vMobileNumber'];
    tiIsSocialLogin = json['tiIsSocialLogin'];
    vProfilePic = json['vProfilePic'];
    vAccessToken = json['vAccessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vUserUuid'] = vUserUuid;
    data['vName'] = vName;
    data['vEmailId'] = vEmailId;
    data['vISDCode'] = vISDCode;
    data['vMobileNumber'] = vMobileNumber;
    data['tiIsSocialLogin'] = tiIsSocialLogin;
    data['vProfilePic'] = vProfilePic;
    data['vAccessToken'] = vAccessToken;
    return data;
  }

  @override
  String toString() {
    return 'UserResponse{vUserUuid: $vUserUuid, vName: $vName, vEmailId: $vEmailId, vISDCode: $vISDCode, vMobileNumber: $vMobileNumber, tiIsSocialLogin: $tiIsSocialLogin, vProfilePic: $vProfilePic, vAccessToken: $vAccessToken}';
  }
}
