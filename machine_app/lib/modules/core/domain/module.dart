import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Module {
  Module(this.ref);

  @protected
  final Ref ref;

  void init();
}
