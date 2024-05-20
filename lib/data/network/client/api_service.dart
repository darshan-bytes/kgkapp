import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:kgk/kgk.dart';

class ApiService implements ApiProvider {
  String apiBaseUrl;

  ApiService({required this.apiBaseUrl});

  @override
  Future<Either<String, dynamic>?> getMethod<T>(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        final response = await http.get(Uri.parse(apiBaseUrl + url), headers: {
          // HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        });

        if (response.statusCode == 200) {
          return Right(jsonDecode(response.body));
        } else {
          return const Left('Failed to fetch data');
        }
      } else {
        return const Left('Check your internet connection and try again');
      }
    } catch (e, s) {
      return const Left('Something went wrong');
    }
  }

  @override
  Future<Either<String, dynamic>?> postMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        final response = await http.post(Uri.parse(apiBaseUrl + url),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
              // Merge headers passed in the parameter
              if (headers != null) ...headers,
            },
            body: jsonEncode(body));

        if (response.statusCode == 200) {
          return Right(jsonDecode(response.body));
        } else {
          return const Left('Failed to post data');
        }
      } else {
        return const Left('Check your internet connection and try again');
      }
    } catch (e, s) {
      return const Left('Something went wrong');
    }
  }

  @override
  Future<Either<String, dynamic>?> putMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        final response = await http.put(Uri.parse(apiBaseUrl + url),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
              // Merge headers passed in the parameter
              if (headers != null) ...headers,
            },
            body: jsonEncode(body));

        if (response.statusCode == 200) {
          return Right(jsonDecode(response.body));
        } else {
          return const Left('Failed to post data');
        }
      } else {
        return const Left('Check your internet connection and try again');
      }
    } catch (e, s) {
      return const Left('Something went wrong');
    }
  }

  @override
  Future<Either<String, dynamic>?> updateMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        final response = await http.patch(Uri.parse(apiBaseUrl + url),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
              // Merge headers passed in the parameter
              if (headers != null) ...headers,
            },
            body: jsonEncode(body));

        if (response.statusCode == 200) {
          return Right(jsonDecode(response.body));
        } else {
          return const Left('Failed to post data');
        }
      } else {
        return const Left('Check your internet connection and try again');
      }
    } catch (e, s) {
      return const Left('Something went wrong');
    }
  }

  @override
  Future<Either<String, dynamic>?> deleteMethod<T>(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        final response = await http.delete(Uri.parse(apiBaseUrl + url), headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        });

        if (response.statusCode == 200) {
          return Right(jsonDecode(response.body));
        } else {
          return const Left('Failed to post data');
        }
      } else {
        return const Left('Check your internet connection and try again');
      }
    } catch (e, s) {
      return const Left('Something went wrong');
    }
  }

  @override
  Future<Either<String, dynamic>?> postMultipartMethod<T>(String url, Map<String, dynamic> body,
      {Map<String, String>? headers, List<File>? files}) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();

        var request = http.MultipartRequest('POST', Uri.parse(apiBaseUrl + url))
          ..headers[HttpHeaders.authorizationHeader] = 'Bearer $token'
          ..headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';

        // Add additional headers if provided
        if (headers != null) {
          headers.forEach((key, value) {
            request.headers[key] = value;
          });
        }

        // Add files to the request if provided
        if (files != null) {
          for (var file in files) {
            var stream = http.ByteStream(file.openRead());
            var length = await file.length();
            var multipartFile = http.MultipartFile(
              'file',
              stream,
              length,
              filename: file.path.split('/').last,
            );
            request.files.add(multipartFile);
          }
        }

        // Add other body parameters if provided
        if (body.isNotEmpty) {
          body.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        }

        var response = await http.Response.fromStream(await request.send());

        if (response.statusCode == 200) {
          return Right(jsonDecode(response.body));
        } else {
          return Left('Failed to post data: ${response.reasonPhrase}');
        }
      } else {
        return const Left('Check your internet connection and try again');
      }
    } catch (e, s) {
      return const Left('Something went wrong');
    }
  }
}
