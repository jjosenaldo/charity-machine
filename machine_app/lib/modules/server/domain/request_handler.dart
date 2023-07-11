sealed class RequestHandler {}

abstract class GetRequestHandler extends RequestHandler {
  String get endpoint;

  Future<void> handle();
}

abstract class PostRequestHandler extends RequestHandler {
  String get endpoint;

  Future<void> handle(String body);
}
