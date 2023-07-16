import 'package:charity/modules/machine/data/service/machine_service.dart';
import 'package:charity/modules/machine/domain/request_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

class HttpMachineService implements MachineService {
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
      case HttpGetRequestHandler _:
        {
          _server.get(handler.endpoint, () async {
            await handler.handle();

            return Response.ok('ok');
          });
        }

      case HttpPostRequestHandler _:
        {
          _server.post(handler.endpoint, (Request request) async {
            await handler.handle(await request.readAsString());

            return Response.ok('ok');
          });
        }

      case BluetoothRequestHandler _:
        {}
    }
  }

  @override
  Future<void> moveServo(int servoId) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
