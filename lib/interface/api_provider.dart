import 'package:dartz/dartz.dart';
import 'package:kgk/kgk.dart';

abstract class ApiProvider {
  Future<Either<String, dynamic>?> getMethod<T>(
    String url, {
    Map<String, dynamic>? query,
  });

  Future<Either<String, dynamic>?> postMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  });

  Future<Either<String, dynamic>?> putMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  });

  Future<Either<String, dynamic>?> updateMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  });

  Future<Either<String, dynamic>?> deleteMethod<T>(
    String url, {
    Map<String, dynamic>? query,
  });

  Future<Either<String, dynamic>?> postMultipartMethod<T>(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    List<File>? files,
  });
}
