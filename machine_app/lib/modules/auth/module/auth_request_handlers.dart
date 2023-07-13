import 'package:charity/modules/auth/domain/entities/user.dart';
import 'package:charity/modules/auth/module/auth_providers.dart';
import 'package:charity/modules/arduino/domain/request_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInRequestHandler implements BluetoothRequestHandler {
  SignInRequestHandler(this.ref);

  final Ref ref;

  @override
  String get endpoint => 'a';

  @override
  Future<void> handle(String id) async {
    final userNotifier = ref.watch(userNotifierProvider.notifier);

    userNotifier.setUser(User(id: id));
  }
}
