sealed class RequestHandler {}

abstract class HttpGetRequestHandler extends RequestHandler {
  String get endpoint;

  Future<void> handle();
}

abstract class HttpPostRequestHandler extends RequestHandler {
  String get endpoint;

  Future<void> handle(String body);
}

abstract class BluetoothRequestHandler extends RequestHandler {
  String get endpoint;

  Future<void> handle(String body);
}
