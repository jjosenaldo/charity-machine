import 'package:charity/modules/auth/module/auth_providers.dart';
import 'package:charity/modules/server/module/server_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> initModules(ProviderContainer container) async {
  _initModules(container);

  await _initServices(container);
}

void _initModules(ProviderContainer container) {
  final modules = [
    container.read(authModuleProvider),
  ];

  for (final module in modules) {
    module.init();
  }
}

Future<void> _initServices(ProviderContainer container) async {
  await container.read(serverServiceProvider).start();
}
