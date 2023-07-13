import 'package:charity/modules/arduino/domain/request_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodDeliveredRequestHandler implements BluetoothRequestHandler {
  FoodDeliveredRequestHandler(this.ref);

  final Ref ref;

  @override
  String get endpoint => 'b';

  @override
  Future<void> handle(String body) async {}
}
