import 'dart:convert';
import 'dart:io';

import 'package:charity/modules/core/data/services/http/http_client.dart';
import 'dart:io' as io;

class DartHttpClient implements HttpClient {
  DartHttpClient._();

  factory DartHttpClient() {
    _instance ??= DartHttpClient._();

    return _instance!;
  }

  static DartHttpClient? _instance;
  final io.HttpClient _dartClient = io.HttpClient();

  @override
  Future<String> get({
    required String url,
    required String endpoint,
    Map<String, Object>? headers,
  }) {
    return _sendRequest(
      url: url,
      endpoint: endpoint,
      headers: headers,
      requestFetcher: () => _dartClient.get(url, 80, endpoint),
    );
  }

  @override
  Future<String> post({
    required String url,
    required String endpoint,
    required Map<String, Object> body,
    Map<String, Object>? headers,
  }) {
    return _sendRequest(
      url: url,
      endpoint: endpoint,
      headers: headers,
      requestFetcher: () async {
        final request = await _dartClient.post(url, 80, endpoint);
        request.write(jsonEncode(body));

        return request;
      },
    );
  }

  Future<String> _sendRequest({
    required String url,
    required String endpoint,
    required Future<HttpClientRequest> Function() requestFetcher,
    Map<String, Object>? headers,
  }) async {
    final request = await requestFetcher();
    headers?.forEach(request.headers.add);

    HttpClientResponse response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();

    _dartClient.close();

    return responseBody;
  }
}
