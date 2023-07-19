import 'package:charity/modules/core/data/services/machine_server_http_client/machine_server_http_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final machineServerHttpClientProvider = Provider(
  // TODO: set actual url
  (ref) => MachineServerHttpClient(ref: ref, url: '10.100.172.198:8000'),
);
