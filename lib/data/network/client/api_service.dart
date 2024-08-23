import 'package:http/http.dart' as http;
import 'package:kgk/kgk.dart';
import 'dart:developer' as kgk_logger;

class ApiService implements ApiProvider {
  // Common method to get headers
  Map<String, String> _getCommonHeaders({Map<String, String>? additionalHeaders, required bool withCurrencyHeader}) {
    String? token = StorageManager().getAuthToken();
    String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";
    String? acceptLanguage = StorageManager().getLocale();
    String? currency = StorageManager().getSelectedCurrency();

    Map<String, String> headers = {
      if (token.isNotNullNorEmpty) HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      ApiKey.xApiKey: apiKey,
      ApiKey.acceptLanguage: acceptLanguage ?? 'en',
    };

    if (withCurrencyHeader) {
      headers[ApiKey.currency] = currency ?? 'INR';
    }

    // Merge additional headers if provided
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  Future<Either<ErrorResponse, dynamic>?> _sendRequest<T>(_ApiType method, String url,
      {Map<String, dynamic>? query,
      dynamic body,
      Map<String, String>? headers,
      bool withFullResponse = false,
      required bool withCurrencyHeader}) async {
    try {
      if (!await ConnectivityManager().checkInternet()) {
        return Left(ErrorResponse(code: 0, message: APPStrings.checkInternet.tr));
      }
      http.Response response;
      // Handle query parameters
      Uri uri = Uri.parse(url);
      if (query != null && query.isNotEmpty) {
        uri = uri.replace(queryParameters: query.map((key, value) => MapEntry(key, value.toString())));
        url = uri.toString();
      }
      kgk_logger.log(
          'Request URL: $url method: ${method.toString()} headers: ${_getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader)} Body:  ${jsonEncode(body)} Query: $query');
      switch (method) {
        case _ApiType.get:
          response = await http.get(Uri.parse(url),
              headers: _getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader));
          break;
        case _ApiType.post:
          response = await http.post(Uri.parse(url),
              headers: _getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader), body: jsonEncode(body));
          break;
        case _ApiType.put:
          response = await http.put(Uri.parse(url),
              headers: _getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader), body: jsonEncode(body));
          break;
        case _ApiType.patch:
          response = await http.patch(Uri.parse(url),
              headers: _getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader), body: jsonEncode(body));
          break;
        case _ApiType.delete:
          response = await http.delete(Uri.parse(url),
              headers: _getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader));
          break;
        default:
          throw Exception('Unsupported HTTP method');
      }

      kgk_logger.log('Request URL: $url Response: ${response.body} StatusCode: ${response.statusCode}');

      var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

      if (commonResponse.isTokenExpired) {
        await StorageManager().clearSession();
        Utils.showSmartModalBottomSheet(context: getNavigatorKeyContext, builder: (context) => const TokenExpireDialog());
        return null;
      }

      return commonResponse.isSuccess
          ? withFullResponse
              ? Right(commonResponse)
              : Right(commonResponse.responseData)
          : Left(ErrorResponse.fromJson(jsonDecode(response.body)));
    } on KGKException catch (e) {
      return Left(ErrorResponse(code: 0, message: e.message));
    } catch (e) {
      return Left(ErrorResponse(code: 0, message: APPStrings.somethingWrong.tr));
    }
  }

  // Implement getMethod using sendRequest
  @override
  Future<Either<ErrorResponse, dynamic>?> getMethod<T>(String url,
      {Map<String, dynamic>? query, Map<String, String>? headers, bool withFullResponse = false, bool withCurrencyHeader = false}) async {
    return _sendRequest<T>(_ApiType.get, url,
        query: query, withFullResponse: withFullResponse, headers: headers, withCurrencyHeader: withCurrencyHeader);
  }

  // Implement postMethod using sendRequest
  @override
  Future<Either<ErrorResponse, dynamic>?> postMethod<T>(String url, dynamic body,
      {Map<String, String>? headers, bool withFullResponse = false, bool withCurrencyHeader = false}) async {
    return _sendRequest<T>(_ApiType.post, url,
        body: body, headers: headers, withFullResponse: withFullResponse, withCurrencyHeader: withCurrencyHeader);
  }

  // Implement putMethod using sendRequest
  @override
  Future<Either<ErrorResponse, dynamic>?> putMethod<T>(String url, dynamic body,
      {Map<String, String>? headers, bool withCurrencyHeader = false}) async {
    return _sendRequest<T>(_ApiType.put, url, body: body, headers: headers, withCurrencyHeader: withCurrencyHeader);
  }

  // Implement patchMethod using sendRequest
  @override
  Future<Either<ErrorResponse, dynamic>?> updateMethod<T>(String url, dynamic body,
      {Map<String, String>? headers, bool withCurrencyHeader = false}) async {
    return _sendRequest<T>(_ApiType.patch, url, body: body, headers: headers, withCurrencyHeader: withCurrencyHeader);
  }

  // Implement deleteMethod using sendRequest
  @override
  Future<Either<ErrorResponse, dynamic>?> deleteMethod<T>(String url,
      {Map<String, dynamic>? query, bool withCurrencyHeader = false}) async {
    return _sendRequest<T>(_ApiType.delete, url, query: query, withCurrencyHeader: withCurrencyHeader);
  }

  @override
  Future<Either<ErrorResponse, dynamic>?> postMultipartMethod<T>(String url, Map<String, dynamic> body,
      {Map<String, String>? headers, List<File>? files, bool withCurrencyHeader = false}) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        String? token = StorageManager().getAuthToken();
        String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";

        var request = http.MultipartRequest('POST', Uri.parse(url))
          ..headers[HttpHeaders.authorizationHeader] = 'Bearer $token'
          ..headers[ApiKey.xApiKey] = apiKey
          ..headers[ApiKey.acceptLanguage] = 'en'
          ..headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';

        if (withCurrencyHeader) {
          String? currency = StorageManager().getSelectedCurrency();
          request.headers[ApiKey.currency] = currency ?? 'INR';
        }

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

        if (commonResponse.isTokenExpired) {
          // Show token expired popup
          Utils.showSmartModalBottomSheet(context: getNavigatorKeyContext, builder: (context) => const TokenExpireDialog());
          return null;
        }

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

enum _ApiType { get, post, put, patch, delete }
