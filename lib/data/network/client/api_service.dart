import 'package:http/http.dart' as http;
import 'package:kgk/kgk.dart';

class ApiService implements ApiProvider {
  // Common method to get headers
  Map<String, String> _getCommonHeaders({Map<String, String>? additionalHeaders}) {
    String? token = StorageManager().getAuthToken();
    String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      ApiKey.xApiKey: apiKey,
      ApiKey.acceptLanguage: 'en',
    };

    // Merge additional headers if provided
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  // Common method to handle all types of api methods
  @override
  Future<Either<ErrorResponse, dynamic>?> getMethod<T>(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        final response = await http.get(
          Uri.parse(url),
          headers: _getCommonHeaders(),
        );

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(jsonDecode(response.body));
        } else {
          ErrorResponse errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
          return Left(errorResponse);
        }
      } else {
        ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.checkInternet.tr);
        return Left(errorResponse);
      }
    } on KGKException catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: e.message);
      return Left(errorResponse);
    } catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.somethingWrong.tr);
      return Left(errorResponse);
    }
  }

  @override
  Future<Either<ErrorResponse, dynamic>?> postMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
    bool withFullResponse = false,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        final response = await http.post(Uri.parse(url), headers: _getCommonHeaders(additionalHeaders: headers), body: jsonEncode(body));

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          if (withFullResponse) {
            return Right(commonResponse);
          }
          return Right(commonResponse.responseData);
        } else {
          ErrorResponse errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
          return Left(errorResponse);
        }
      } else {
        ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.checkInternet.tr);
        return Left(errorResponse);
      }
    } on KGKException catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: e.message);
      return Left(errorResponse);
    } catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.somethingWrong.tr);
      return Left(errorResponse);
    }
  }

  @override
  Future<Either<ErrorResponse, dynamic>?> putMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        final response = await http.put(Uri.parse(url), headers: _getCommonHeaders(additionalHeaders: headers), body: jsonEncode(body));

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(jsonDecode(response.body));
        } else {
          ErrorResponse errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
          return Left(errorResponse);
        }
      } else {
        ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.checkInternet.tr);
        return Left(errorResponse);
      }
    } on KGKException catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: e.message);
      return Left(errorResponse);
    } catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.somethingWrong.tr);
      return Left(errorResponse);
    }
  }

  @override
  Future<Either<ErrorResponse, dynamic>?> updateMethod<T>(
    String url,
    dynamic body, {
    Map<String, String>? headers,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        final response = await http.patch(Uri.parse(url), headers: _getCommonHeaders(additionalHeaders: headers), body: jsonEncode(body));

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(jsonDecode(response.body));
        } else {
          ErrorResponse errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
          return Left(errorResponse);
        }
      } else {
        ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.checkInternet.tr);
        return Left(errorResponse);
      }
    } on KGKException catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: e.message);
      return Left(errorResponse);
    } catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.somethingWrong.tr);
      return Left(errorResponse);
    }
  }

  @override
  Future<Either<ErrorResponse, dynamic>?> deleteMethod<T>(
    String url, {
    Map<String, dynamic>? query,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        final response = await http.delete(
          Uri.parse(url),
          headers: _getCommonHeaders(),
        );

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isSuccess) {
          return Right(jsonDecode(response.body));
        } else {
          ErrorResponse errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
          return Left(errorResponse);
        }
      } else {
        ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.checkInternet.tr);
        return Left(errorResponse);
      }
    } on KGKException catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: e.message);
      return Left(errorResponse);
    } catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.somethingWrong.tr);
      return Left(errorResponse);
    }
  }

  @override
  Future<Either<ErrorResponse, dynamic>?> postMultipartMethod<T>(String url, Map<String, dynamic> body,
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
          ErrorResponse errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
          return Left(errorResponse);
        }
      } else {
        ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.checkInternet.tr);
        return Left(errorResponse);
      }
    } on KGKException catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: e.message);
      return Left(errorResponse);
    } catch (e) {
      ErrorResponse errorResponse = ErrorResponse(code: 0, message: APPStrings.somethingWrong.tr);
      return Left(errorResponse);
    }
  }
}
