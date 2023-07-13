import 'package:charity/modules/arduino/domain/request_handler.dart';

abstract class ArduinoService {
  Future<void> start();

  void registerRequestHandler({required RequestHandler handler});

  Future<void> moveServo(int servoId);
}
