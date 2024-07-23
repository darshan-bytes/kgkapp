class KGKException implements Exception{
  final String message;
  final String code;

  KGKException({required this.message, required this.code});

  @override
  String toString() {
    return 'KGKException{message: $message, code: $code}';
  }
}