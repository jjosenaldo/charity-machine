import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class UserDelegate {
  String getUser(Ref ref);
}
