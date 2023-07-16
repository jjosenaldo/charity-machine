import 'package:charity/modules/auth/module/auth_request_handlers.dart';
import 'package:charity/modules/core/domain/module.dart';
import 'package:charity/modules/machine/module/machine_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthModule extends Module {
  AuthModule(super.ref);

  @override
  void init() {
    _registerRequestHandlers(ref);
  }

  void _registerRequestHandlers(Ref ref) {
    final machineService = ref.watch(machineServiceProvider);

    machineService.registerRequestHandler(handler: SignInRequestHandler(ref));
  }
}
