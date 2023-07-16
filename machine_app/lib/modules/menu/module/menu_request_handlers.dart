import 'package:charity/modules/machine/domain/request_handler.dart';
import 'package:charity/modules/menu/menu_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemDeliveredRequestHandler implements BluetoothRequestHandler {
  ItemDeliveredRequestHandler(this.ref);

  final Ref ref;

  @override
  String get endpoint => 'b';

  @override
  Future<void> handle(String _) async {
    ref.read(itemPickNotifierProvider.notifier).takeItem();
  }
}

class HttpItemDeliveredRequestHandler implements HttpGetRequestHandler {
  HttpItemDeliveredRequestHandler(this.ref);

  final Ref ref;

  @override
  String get endpoint => '/item-delivered';

  @override
  Future<void> handle() async {
    ref.read(itemPickNotifierProvider.notifier).takeItem();
  }
}
