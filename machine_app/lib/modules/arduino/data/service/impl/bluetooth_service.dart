import 'dart:convert';
import 'dart:typed_data';

import 'package:charity/modules/arduino/data/service/arduino_service.dart';
import 'package:charity/modules/arduino/domain/request_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothService implements ArduinoService {
  final _handlers = <BluetoothRequestHandler>[];
  late final _MessageParser _parser = _MessageParser(handlers: _handlers);

  BluetoothDevice? _device;
  BluetoothConnection? _connection;

  @override
  Future<void> start() async {
    _setDevice();
  }

  @override
  void registerRequestHandler({required RequestHandler handler}) {
    // Once [_parser] is used once, this method effectively does nothing.
    if (handler is BluetoothRequestHandler) {
      _handlers.add(handler);
    }
  }

  void _setDevice() {
    debugPrint('setDevice()');
    final currentDevice = _device;

    if (currentDevice == null) {
      debugPrint('startDiscovery()');
      FlutterBluetoothSerial.instance.startDiscovery().listen((result) async {
        final device = result.device;
        debugPrint('device discovered: ${device.name}');

        if (device.name?.contains('HC-06') ?? false) {
          _device = device;

          if (!device.isConnected) {
            _connect(device);
          }
        }
      });
    }
  }

  Future<void> _connect(BluetoothDevice device) async {
    _connection = await BluetoothConnection.toAddress(device.address);
    _connection?.input?.listen((Uint8List data) {
      final message = ascii.decode(data);
      for (int i = 0; i < message.length; i++) {
        _parser.onCharReceived(message[i]);
      }
    });
  }

  @override
  Future<void> moveServo(int servoId) async {
    debugPrint('[BluetoothService] moveServo($servoId)');
    final connection = _connection;

    if (connection != null) {
      debugPrint('[BluetoothService] sending to arduino: $servoId');
      connection.output.add(Uint8List.fromList('$servoId'.codeUnits));
    }
  }
}

class _MessageParser {
  _MessageParser({required this.handlers});

  static const String _messageEnd = '\$';
  final List<BluetoothRequestHandler> handlers;
  String _buffer = "";
  BluetoothRequestHandler? _currentHandler;

  void onCharReceived(String char) {
    _buffer += char;

    if (char[0] != _messageEnd) {
      return;
    }

    final messageId = _buffer[0];
    debugPrint('messageId: $messageId');
    // Assumes that there is at least one handler for each endpoint
    _currentHandler =
        handlers.firstWhere((handler) => handler.endpoint == messageId);

    final content = _buffer.substring(1, _buffer.length - 1);
    debugPrint('content: $content');
    _currentHandler!.handle(content);
    _buffer = '';
  }
}
