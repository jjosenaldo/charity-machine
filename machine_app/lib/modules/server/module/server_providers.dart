import 'package:charity/modules/server/data/service/impl/shelf_server_service.dart';
import 'package:charity/modules/server/data/service/server_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serverServiceProvider = Provider<ServerService>((ref) {
  return ShelfServerService();
});
