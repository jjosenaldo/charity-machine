import 'dart:developer';

import 'package:charity/modules/auth/domain/entities/auth_user_delegate.dart';
import 'package:charity/modules/auth/module/auth_providers.dart';
import 'package:charity/modules/core/data/services/machine_server_http_client/machine_server_http_client_providers.dart';
import 'package:charity/modules/core/domain/entities/module.dart';
import 'package:charity/modules/machine/module/machine_providers.dart';
import 'package:charity/modules/menu/module/menu_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class MainModule extends Module {
  MainModule(super.ref);

  Future<void> initModules(ProviderContainer container) async {
    _initLogging();
    _initAppModules(container);

    await _initServices(container);
  }

  void _initLogging() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      log(record.message, level: record.level.value, name: record.loggerName);
    });
  }

  void _initAppModules(ProviderContainer container) {
    _initCore();

    final modules = [
      container.read(authModuleProvider),
      container.read(menuModuleProvider),
    ];

    for (final module in modules) {
      module.init();
    }
  }

  Future<void> _initServices(ProviderContainer container) async {
    await container.read(machineServiceProvider).start();
  }

  void _initCore() {
    ref
        .read(machineServerHttpClientProvider)
        .configure(userDelegate: AuthUserDelegate());
  }
}
