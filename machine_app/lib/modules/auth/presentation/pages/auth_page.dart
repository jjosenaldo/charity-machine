import 'dart:convert';
import 'dart:typed_data';

import 'package:charity/modules/auth/module/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: add logout button (to all pages?)
class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  Future<void> _scan() async {
    FlutterBluetoothSerial.instance.startDiscovery().listen((r) async {
      if (r.device.name?.contains('HC-06') ?? false) {
        BluetoothConnection connection =
            await BluetoothConnection.toAddress(r.device.address);

        connection.output
            .add(Uint8List.fromList(utf8.encode('hello world carai' "\r\n")));

        connection.input?.listen((Uint8List data) {
          debugPrint('Data incoming: ${ascii.decode(data)}');
        }).onDone(() {
          debugPrint('Disconnected by remote request');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userNotifierProvider, (_, newUser) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        'category',
        (Route<dynamic> route) => false,
      );
    });

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _scan,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Spacer(),
                const Icon(
                  Icons.credit_card,
                  size: 50,
                  color: Colors.black,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Aproxime sua tag do leitor',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
