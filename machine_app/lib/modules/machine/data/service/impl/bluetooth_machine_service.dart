import 'dart:convert';
import 'dart:typed_data';

import 'package:charity/modules/machine/data/service/machine_service.dart';
import 'package:charity/modules/machine/domain/request_handler.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:logging/logging.dart';

class BluetoothMachineService implements MachineService {
  final _handlers = <BluetoothRequestHandler>[];
  late final _MessageParser _parser = _MessageParser(handlers: _handlers);
  final _log = Logger('Bluetooth');

  BluetoothDevice? _device;
  BluetoothConnection? _connection;

  @override
  Future<void> start() async {
    _setDevice();
  }

  @override
  void registerRequestHandlers({required Iterable<RequestHandler> handlers}) {
    // Once [_parser] is used once, this method effectively does nothing.
    for (final handler in handlers) {
      if (handler is BluetoothRequestHandler) {
        _handlers.add(handler);
      }
    }
  }

  @override
  Future<void> dispenseFrom(int servoId) async {
    _sendString('$servoId');
  }

  void _setDevice() {
    final currentDevice = _device;

    if (currentDevice == null) {
      FlutterBluetoothSerial.instance.startDiscovery().listen((result) async {
        final device = result.device;

        if (device.name?.contains('HC-06') ?? false) {
          _log.fine('device discovered: ${device.name}');
          _device = device;

          if (!device.isConnected) {
            _connect(device);
          }
        } else {
          _log.info('device discovered: ${device.name}');
        }
      });
    }
  }

  Future<void> _connect(BluetoothDevice device) async {
    _connection = await BluetoothConnection.toAddress(device.address);
    _connection?.input?.listen((Uint8List data) {
      final message = ascii.decode(data);
      _log.info('message received: $message');

      for (int i = 0; i < message.length; i++) {
        _parser.onCharReceived(message[i]);
      }
    });
  }

  void _sendString(String data) {
    final connection = _connection;

    if (connection != null) {
      _log.info('sending string $data');
      connection.output.add(Uint8List.fromList(data.codeUnits));
    } else {
      _log.severe('error sending $data: no connection');
    }
  }
}

class _MessageParser {
  _MessageParser({required this.handlers});

  static const String _messageEnd = '\$';
  final List<BluetoothRequestHandler> handlers;
  final _log = Logger('MessageParser');
  String _buffer = "";
  BluetoothRequestHandler? _currentHandler;

  void onCharReceived(String char) {
    _buffer += char;

    if (char[0] != _messageEnd) {
      return;
    }

    final messageId = _buffer[0];
    _log.info('messageId: $messageId');
    // Assumes that there is at least one handler for each endpoint
    _currentHandler =
        handlers.firstWhere((handler) => handler.endpoint == messageId);

    final content = _buffer.substring(1, _buffer.length - 1);
    _log.info('content ($messageId): $content');
    _currentHandler!.handle(content);
    _buffer = '';
  }
}
