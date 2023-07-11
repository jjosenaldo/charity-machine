import 'package:charity/modules/auth/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User.empty());

  User get currentUser => state;

  void setUser(User newUser) {
    state = newUser;
  }
}
