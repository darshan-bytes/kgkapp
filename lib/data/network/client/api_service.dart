import 'package:http/http.dart' as http;
import 'package:kgk/kgk.dart';

class ApiService implements ApiProvider {
  @override
  Future<Either<String, dynamic>?> getMethod<T>(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();
        String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";

        final response = await http.get(Uri.parse(url), headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          ApiKey.xApiKey: apiKey,
          ApiKey.acceptLanguage: 'en',
        });

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(jsonDecode(response.body));
        } else {
          return Left(APPStrings.failedFetchData.tr);
        }
      } else {
        return Left(APPStrings.checkInternet.tr);
      }
    } catch (e) {
      return Left(APPStrings.somethingWrong.tr);
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
        String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";

        final response = await http.post(Uri.parse(url),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
              ApiKey.xApiKey: apiKey,
              ApiKey.acceptLanguage: 'en',
              // Merge headers passed in the parameter
              if (headers != null) ...headers,
            },
            body: jsonEncode(body));

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(commonResponse.responseData);
        } else {
          return Left(commonResponse.message ?? '');
        }
      } else {
        return Left(APPStrings.checkInternet.tr);
      }
    } catch (e) {
      return Left(APPStrings.somethingWrong.tr);
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
        String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";

        final response = await http.put(Uri.parse(url),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
              ApiKey.xApiKey: apiKey,
              ApiKey.acceptLanguage: 'en',
              // Merge headers passed in the parameter
              if (headers != null) ...headers,
            },
            body: jsonEncode(body));

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(jsonDecode(response.body));
        } else {
          return const Left('Failed to post data');
        }
      } else {
        return Left(APPStrings.checkInternet.tr);
      }
    } catch (e) {
      return Left(APPStrings.somethingWrong.tr);
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
        String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";

        final response = await http.patch(Uri.parse(url),
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
              HttpHeaders.contentTypeHeader: 'application/json',
              ApiKey.xApiKey: apiKey,
              ApiKey.acceptLanguage: 'en',
              // Merge headers passed in the parameter
              if (headers != null) ...headers,
            },
            body: jsonEncode(body));

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(jsonDecode(response.body));
        } else {
          return const Left('Failed to post data');
        }
      } else {
        return Left(APPStrings.checkInternet.tr);
      }
    } catch (e) {
      return Left(APPStrings.somethingWrong.tr);
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
        String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";

        final response = await http.delete(Uri.parse(url), headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
          ApiKey.xApiKey: apiKey,
          ApiKey.acceptLanguage: 'en',
        });

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(jsonDecode(response.body));
        } else {
          return const Left('Failed to post data');
        }
      } else {
        return Left(APPStrings.checkInternet.tr);
      }
    } catch (e) {
      return Left(APPStrings.somethingWrong.tr);
    }
  }

  @override
  Future<Either<String, dynamic>?> postMultipartMethod<T>(String url, Map<String, dynamic> body,
      {Map<String, String>? headers, List<File>? files}) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();
        String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";

        var request = http.MultipartRequest('POST', Uri.parse(url))
          ..headers[HttpHeaders.authorizationHeader] = 'Bearer $token'
          ..headers[ApiKey.xApiKey] = apiKey
          ..headers[ApiKey.acceptLanguage] = 'en'
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

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(jsonDecode(response.body));
        } else {
          return Left('Failed to post data: ${response.reasonPhrase}');
        }
      } else {
        return Left(APPStrings.checkInternet.tr);
      }
    } catch (e) {
      return Left(APPStrings.somethingWrong.tr);
    }
  }
}
