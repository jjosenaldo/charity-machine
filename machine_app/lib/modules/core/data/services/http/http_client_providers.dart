import 'package:charity/modules/core/data/services/http/http_client.dart';
import 'package:charity/modules/core/data/services/http/impl/dart_http_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = Provider<HttpClient>((_) => DartHttpClient());
