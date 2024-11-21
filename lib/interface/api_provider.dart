import 'package:kgk/kgk.dart';

abstract class ApiProvider {
  Future<Either<ErrorResponse, dynamic>?> getMethod<T>(
    String url, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  Future<Either<ErrorResponse, dynamic>?> postMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  });

  Future<Either<ErrorResponse, dynamic>?> putMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  });

  Future<Either<ErrorResponse, dynamic>?> updateMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  });

  Future<Either<ErrorResponse, dynamic>?> deleteMethod<T>(
    String url, {
    Map<String, dynamic>? query,
  });

  Future<Either<ErrorResponse, dynamic>?> postMultipartMethod<T>(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    List<ModelMultiPartFile>? files,
  });

  Future<Either<ErrorResponse, dynamic>?> putMultipartMethod<T>(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    List<ModelMultiPartFile>? files,
  });
}
