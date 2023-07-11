import 'package:charity/modules/auth/domain/entities/user.dart';
import 'package:charity/modules/auth/module/auth_providers.dart';
import 'package:charity/modules/server/domain/request_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInRequestHandler implements PostRequestHandler {
  SignInRequestHandler(this.ref);

  final Ref ref;

  @override
  String get endpoint => '/login';

  @override
  Future<void> handle(String body) async {
    debugPrint('SignInRequestHandler.handle()');
    final userNotifier = ref.watch(userNotifierProvider.notifier);

    userNotifier.setUser(User(id: body));
  }
}
