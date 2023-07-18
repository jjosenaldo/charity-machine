import 'package:charity/modules/machine/module/machine_providers.dart';
import 'package:charity/modules/core/domain/entities/module.dart';
import 'package:charity/modules/menu/module/menu_request_handlers.dart';

class MenuModule extends Module {
  MenuModule(super.ref);

  @override
  void init() {
    _registerRequestHandlers();
  }

  void _registerRequestHandlers() {
    final machineService = ref.watch(machineServiceProvider);

    machineService.registerRequestHandlers(handlers: [
      ItemDeliveredRequestHandler(ref),
      HttpItemDeliveredRequestHandler(ref),
      ItemAvailableRequestHandler(ref),
      HttpItemAvailableRequestHandler(ref),
    ]);
  }
}
