abstract class HttpClient {
  Future<String> get({
    required String url,
    required String endpoint,
    Map<String, String>? headers,
  });

  Future<String> post({
    required String url,
    required String endpoint,
    required Map<String, Object> body,
    Map<String, String>? headers,
  });
}
