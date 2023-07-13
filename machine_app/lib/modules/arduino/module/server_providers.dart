import 'package:charity/modules/arduino/data/service/impl/bluetooth_service.dart';
import 'package:charity/modules/arduino/data/service/arduino_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final arduinoProvider = Provider<ArduinoService>((ref) {
  return BluetoothService();
});
