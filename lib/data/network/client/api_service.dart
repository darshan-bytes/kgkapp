import 'package:http/http.dart' as http;
import 'package:kgk/kgk.dart';
import 'dart:developer' as kgk_logger;

class ApiService implements ApiProvider {
  // Common method to get headers
  Map<String, String> _getCommonHeaders({Map<String, String>? additionalHeaders, required bool withCurrencyHeader}) {
    String? token = StorageManager().getAuthToken();
    // Ankita User Token
    // String? token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjM4OTIiLCJpc19hZG1pbiI6dHJ1ZSwidXNlcl90eXBlIjoiY3VzdG9tZXIiLCJjb3VudHJ5X2NvZGUiOiJJTiIsInJvbGUiOiJpbmRpdmlkdWFsLXJvbGUiLCJjdXN0b21lcl9vcmdhbml6YXRpb25faWQiOiIzMTcxOCIsImlhdCI6MTczMzkyNjEyOSwiZXhwIjoxNzM0NTMwOTI5fQ.SbFMhmBCEjFE1D2uoTlGxXMAmHx0c3r0BfCDaEEx4Yg';
    String? apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";
    String? acceptLanguage = StorageManager().getLocale();
    String? currency = StorageManager().getSelectedCurrency()?.code;

    printWrapped("Token ::::: $token");

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
          '🔷 Request URL: $url method: ${method.toString()} headers: ${_getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader)} Body:  ${jsonEncode(body)} Query: ${jsonEncode(query)}');
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
              headers: _getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader),
              body: body == null ? null : jsonEncode(body));
          break;
      }

      kgk_logger.log('🔶 Request URL: $url Response: ${response.body} StatusCode: ${response.statusCode}');

      var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

      if (commonResponse.isTokenExpired) {
        if (!StorageManager().getIsSkipLogin()) {
          await StorageManager().clearSession();
          Utils.showSmartModalBottomSheet(context: getNavigatorKeyContext, builder: (context) => const TokenExpireDialog());
        }
        return null;
      }

      return commonResponse.isSuccess
          ? withFullResponse
              ? Right(commonResponse)
              : Right(commonResponse.responseData)
          : Left(ErrorResponse.fromJson(jsonDecode(response.body)));
    } on KGKException catch (e) {
      return Left(ErrorResponse(code: 0, message: e.message));
    } on SocketException catch (e) {
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
      {Map<String, String>? headers, bool withCurrencyHeader = false, bool withFullResponse = false}) async {
    return _sendRequest<T>(_ApiType.put, url,
        body: body, headers: headers, withCurrencyHeader: withCurrencyHeader, withFullResponse: withFullResponse);
  }

  // Implement patchMethod using sendRequest
  @override
  Future<Either<ErrorResponse, dynamic>?> updateMethod<T>(String url, dynamic body,
      {Map<String, String>? headers, bool withCurrencyHeader = false, bool withFullResponse = false}) async {
    return _sendRequest<T>(_ApiType.patch, url,
        body: body, headers: headers, withCurrencyHeader: withCurrencyHeader, withFullResponse: withFullResponse);
  }

  // Implement deleteMethod using sendRequest
  @override
  Future<Either<ErrorResponse, dynamic>?> deleteMethod<T>(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? query, bool withCurrencyHeader = false, bool withFullResponse = false}) async {
    return _sendRequest<T>(_ApiType.delete, url,
        query: query, withCurrencyHeader: withCurrencyHeader, withFullResponse: withFullResponse, body: body);
  }

  @override
  Future<Either<ErrorResponse, dynamic>?> postMultipartMethod<T>(String url, Map<String, dynamic> body,
      {Map<String, String>? headers,
      Map<String, dynamic>? query,
      List<ModelMultiPartFile>? files,
      bool withCurrencyHeader = false,
      bool withFullResponse = false}) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        Uri uri = Uri.parse(url);
        if (query != null && query.isNotEmpty) {
          uri = uri.replace(queryParameters: query.map((key, value) => MapEntry(key, value.toString())));
          url = uri.toString();
        }

        var request = http.MultipartRequest('POST', Uri.parse(url));

        _getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader).forEach((key, value) {
          request.headers[key] = value;
        });

        // Add files to the request if provided
        if (files != null) {
          for (var fileData in files) {
            File file = File(fileData.filePath);
            String fileName = (fileData.filePath).split('/').last;
            List<String> mimeType = (mime(fileName) ?? '').split('/');
            var stream = http.ByteStream(file.openRead());
            var length = await file.length();
            var multipartFile = http.MultipartFile(
              fileData.apiKey,
              stream,
              length,
              filename: fileName.split('.').first.toLowerCase(),
              contentType: MediaType(mimeType.first, mimeType.last),
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

        kgk_logger.log(
            'Request URL: $url method: postMultipartMethod headers: ${_getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader)} Body:  ${jsonEncode(body)} Query: ${jsonEncode(query)}');

        var response = await http.Response.fromStream(await request.send());

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isTokenExpired) {
          // Show token expired popup
          Utils.showSmartModalBottomSheet(context: getNavigatorKeyContext, builder: (context) => const TokenExpireDialog());
          return null;
        }

        return commonResponse.isSuccess
            ? withFullResponse
                ? Right(commonResponse)
                : Right(commonResponse.responseData)
            : Left(ErrorResponse.fromJson(jsonDecode(response.body)));
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
  Future<Either<ErrorResponse, dynamic>?> putMultipartMethod<T>(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    List<ModelMultiPartFile>? files,
    bool withFullResponse = false,
    bool withCurrencyHeader = false,
  }) async {
    try {
      if (await ConnectivityManager().checkInternet()) {
        Uri uri = Uri.parse(url);
        if (query != null && query.isNotEmpty) {
          uri = uri.replace(queryParameters: query.map((key, value) => MapEntry(key, value.toString())));
          url = uri.toString();
        }

        var request = http.MultipartRequest('PUT', Uri.parse(url));

        _getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader).forEach((key, value) {
          request.headers[key] = value;
        });

        // Add files to the request if provided
        if (files != null) {
          for (var fileData in files) {
            File file = File(fileData.filePath);
            String fileName = (fileData.filePath).split('/').last;
            List<String> mimeType = (mime(fileName) ?? '').split('/');
            var stream = http.ByteStream(file.openRead());
            var length = await file.length();
            var multipartFile = http.MultipartFile(
              fileData.apiKey,
              stream,
              length,
              filename: fileName.split('.').first.toLowerCase(),
              contentType: MediaType(mimeType.first, mimeType.last),
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

        kgk_logger.log(
            'Request URL: $url method: Patch Multipart Method headers: ${_getCommonHeaders(additionalHeaders: headers, withCurrencyHeader: withCurrencyHeader)} Body:  ${jsonEncode(body)} Query: ${jsonEncode(query)}');

        var response = await http.Response.fromStream(await request.send());

        var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));

        if (commonResponse.isTokenExpired) {
          //TODO: Show token expired popup
          // Utils.showSmartModalBottomSheet(context: getNavigatorKeyContext, builder: (context) => const TokenExpireDialog());
          return null;
        }

        return commonResponse.isSuccess
            ? withFullResponse
                ? Right(commonResponse)
                : Right(commonResponse.responseData)
            : Left(ErrorResponse.fromJson(jsonDecode(response.body)));
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

///[ModelMultiPartFile] is used for file value
class ModelMultiPartFile {
  String filePath;
  String apiKey;

  ModelMultiPartFile({required this.filePath, required this.apiKey});
}
