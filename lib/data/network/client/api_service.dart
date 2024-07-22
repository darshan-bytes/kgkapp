import 'package:http/http.dart' as http;
import 'package:kgk/kgk.dart';

class ApiService implements ApiProvider {
  final ConnectivityManager _connectivityManager;
  final StorageManager _storageManager;

  ApiService({
    ConnectivityManager? connectivityManager,
    StorageManager? storageManager,
  })  : _connectivityManager = connectivityManager ?? ConnectivityManager(),
        _storageManager = storageManager ?? StorageManager();

  static const String _apiKey = "1ab2c3d4e5f61ab2c3d4e5f6";
  static const String _lang = 'en';

  Future<Map<String, String>> _getHeaders([Map<String, String>? additionalHeaders]) async {
    String? token = _storageManager.getAuthToken();
    return {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
      ApiKey.xApiKey: _apiKey,
      ApiKey.acceptLanguage: _lang,
      if (additionalHeaders != null) ...additionalHeaders,
    };
  }

  Future<Either<String, dynamic>?> _performRequest<T>(Future<http.Response> Function() requestFunction) async {
    try {
      if (await _connectivityManager.checkInternet()) {
        final response = await requestFunction();
        return _handleResponse<T>(response);
      } else {
        return Left(APPStrings.checkInternet.tr);
      }
    } catch (e) {
      return Left(APPStrings.somethingWrong.tr);
    }
  }

  Either<String, dynamic> _handleResponse<T>(http.Response response) {
    var commonResponse = CommonResponse<T>.fromJson(jsonDecode(response.body));
    if (response.statusCode == commonResponse.statusCode) {
      return commonResponse.isSuccess ? Right(commonResponse.responseData) : Left(commonResponse.message ?? '');
    } else {
      return Left(APPStrings.failedFetchData.tr);
    }
  }

  @override
  Future<Either<String, dynamic>?> getMethod<T>(String url, {Map<String, dynamic>? query}) async {
    return _performRequest(() async {
      final headers = await _getHeaders();
      return http.get(Uri.parse(url), headers: headers);
    });
  }

  @override
  Future<Either<String, dynamic>?> postMethod<T>(String url,
      dynamic body, {
        Map<String, String>? headers,
      }) async {
    return _performRequest(() async {
      final combinedHeaders = await _getHeaders(headers);
      return http.post(Uri.parse(url), headers: combinedHeaders, body: jsonEncode(body));
    });
  }

  @override
  Future<Either<String, dynamic>?> putMethod<T>(String url,
      dynamic body, {
        Map<String, String>? headers,
      }) async {
    return _performRequest(() async {
      final combinedHeaders = await _getHeaders(headers);
      return http.put(Uri.parse(url), headers: combinedHeaders, body: jsonEncode(body));
    });
  }

  @override
  Future<Either<String, dynamic>?> updateMethod<T>(String url,
      dynamic body, {
        Map<String, String>? headers,
      }) async {
    return _performRequest(() async {
      final combinedHeaders = await _getHeaders(headers);
      return http.patch(Uri.parse(url), headers: combinedHeaders, body: jsonEncode(body));
    });
  }

  @override
  Future<Either<String, dynamic>?> deleteMethod<T>(String url, {
    Map<String, dynamic>? query,
  }) async {
    return _performRequest(() async {
      final headers = await _getHeaders();
      return http.delete(Uri.parse(url), headers: headers);
    });
  }

  @override
  Future<Either<String, dynamic>?> postMultipartMethod<T>(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
    List<File>? files,
  }) async {
    return _performRequest(() async {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(await _getHeaders(headers));

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

      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      var streamedResponse = await request.send();
      return http.Response.fromStream(streamedResponse);
    });
  }
}