import 'package:charity/modules/machine/domain/request_handler.dart';

abstract class MachineService {
  Future<void> start();

  void registerRequestHandlers({required Iterable<RequestHandler> handlers});

  Future<void> dispenseFrom(int position);
}
