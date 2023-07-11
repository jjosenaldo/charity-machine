import 'package:charity/modules/server/data/service/server_service.dart';
import 'package:charity/modules/server/domain/request_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

class ShelfServerService implements ServerService {
  final _server = Router();
  static const _kPort = 12345;
  static const _kUrl = '0.0.0.0';

  @override
  Future<void> start() async {
    await shelf_io.serve(_server, _kUrl, _kPort);
  }

  @override
  void registerRequestHandler({required RequestHandler handler}) {
    switch (handler) {
      case GetRequestHandler _:
        {
          _server.get(handler.endpoint, () async {
            await handler.handle();

            return Response.ok('ok');
          });
        }

      case PostRequestHandler _:
        {
          _server.post(handler.endpoint, (Request request) async {
            await handler.handle(await request.readAsString());

            return Response.ok('ok');
          });
        }
    }
  }
}
