import 'package:charity/modules/auth/module/auth_request_handlers.dart';
import 'package:charity/modules/core/domain/entities/module.dart';
import 'package:charity/modules/machine/module/machine_providers.dart';

class AuthModule extends Module {
  AuthModule(super.ref);

  @override
  void init() {
    _registerRequestHandlers();
  }

  void _registerRequestHandlers() {
    final machineService = ref.watch(machineServiceProvider);

    machineService.registerRequestHandlers(handlers: [
      SignInRequestHandler(ref),
      HttpSignInRequestHandler(ref),
    ]);
  }
}
