import 'package:charity/modules/auth/domain/entities/user.dart';
import 'package:charity/modules/auth/domain/notifiers/user_notifier.dart';
import 'package:charity/modules/auth/module/auth_module.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNotifierProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

final authModuleProvider = Provider<AuthModule>((ref) => AuthModule(ref));
