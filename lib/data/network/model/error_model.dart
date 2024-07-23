class ErrorResponse {
  int? code;
  String? message;

  ErrorResponse({this.code, this.message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    code = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = code;
    data['message'] = message;
    return data;
  }

  @override
  String toString() {
    return 'ErrorModel{code: $code, message: $message}';
  }
}
