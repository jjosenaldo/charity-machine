import 'package:charity/modules/machine/domain/request_handler.dart';

abstract class MachineService {
  Future<void> start();

  void registerRequestHandler({required RequestHandler handler});

  Future<void> moveServo(int servoId);
}
