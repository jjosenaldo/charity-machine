import 'package:charity/modules/server/domain/request_handler.dart';

abstract class ServerService {
  Future<void> start();

  void registerRequestHandler({required RequestHandler handler});
}
