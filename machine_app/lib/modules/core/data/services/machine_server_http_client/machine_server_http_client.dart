import 'package:charity/modules/core/data/services/http/http_client_providers.dart';
import 'package:charity/modules/core/data/services/machine_server_http_client/user_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MachineServerHttpClient {
  MachineServerHttpClient({
    required this.ref,
    required this.url,
  });

  final Ref ref;
  final String url;
  late final UserDelegate _userDelegate;
  late final _httpClient = ref.read(httpClientProvider);

  void configure({required UserDelegate userDelegate}) {
    _userDelegate = userDelegate;
  }

  Future<String> get({
    required String endpoint,
    bool hasAuth = true,
  }) {
    return _httpClient.get(
      url: url,
      endpoint: endpoint,
      headers: _getHeaders(hasAuth),
    );
  }

  Future<String> post({
    required String endpoint,
    required Map<String, Object> body,
    bool hasAuth = true,
  }) {
    return _httpClient.post(
      url: url,
      endpoint: endpoint,
      body: body,
      headers: _getHeaders(hasAuth),
    );
  }

  Map<String, String> _getHeaders(bool hasAuth) => {
        if (hasAuth) 'Authorization': _userDelegate.getUser(ref),
      };
}
