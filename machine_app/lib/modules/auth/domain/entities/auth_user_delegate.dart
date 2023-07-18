import 'package:charity/modules/auth/module/auth_providers.dart';
import 'package:charity/modules/core/data/services/machine_server_http_client/user_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthUserDelegate implements UserDelegate {
  @override
  String getUser(Ref ref) =>
      ref.read(userNotifierProvider.notifier).currentUser.id;
}
