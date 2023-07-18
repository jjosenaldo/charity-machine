import 'package:charity/modules/core/data/services/http/http_client.dart';
import 'package:http/http.dart';

// TODO: throw exception on get and post when the response code is not 20*
class DartHttpClient implements HttpClient {
  DartHttpClient._();

  factory DartHttpClient() {
    _instance ??= DartHttpClient._();

    return _instance!;
  }

  static DartHttpClient? _instance;
  final Client _dartClient = Client();

  @override
  Future<String> get({
    required String url,
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    return (await _dartClient.get(
      Uri.http(url, endpoint),
      headers: headers,
    ))
        .body;
  }

  @override
  Future<String> post({
    required String url,
    required String endpoint,
    required Map<String, Object> body,
    Map<String, String>? headers,
  }) async {
    return (await _dartClient.get(
      Uri.http(url, endpoint),
      headers: headers,
    ))
        .body;
  }
}
