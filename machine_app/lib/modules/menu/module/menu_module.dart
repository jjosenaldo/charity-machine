import 'package:charity/modules/arduino/module/server_providers.dart';
import 'package:charity/modules/core/domain/module.dart';
import 'package:charity/modules/menu/module/menu_request_handlers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuModule extends Module {
  MenuModule(super.ref);

  @override
  void init() {
    _registerRequestHandlers(ref);
  }

  void _registerRequestHandlers(Ref ref) {
    final arduinoService = ref.watch(arduinoProvider);

    arduinoService.registerRequestHandler(
        handler: FoodDeliveredRequestHandler(ref));
  }
}
