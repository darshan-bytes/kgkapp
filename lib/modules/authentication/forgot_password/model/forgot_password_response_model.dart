class ForgotPasswordModel {
  ErrorModel? error;

  ForgotPasswordModel({this.error});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? ErrorModel.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (error != null) {
      data['error'] = error!.toJson();
    }
    return data;
  }
}

class ErrorModel {
  String? code;
  String? response;
  int? responseCode;
  String? command;

  ErrorModel({this.code, this.response, this.responseCode, this.command});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    response = json['response'];
    responseCode = json['responseCode'];
    command = json['command'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['response'] = response;
    data['responseCode'] = responseCode;
    data['command'] = command;
    return data;
  }
}
