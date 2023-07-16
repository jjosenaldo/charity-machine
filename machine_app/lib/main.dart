import 'dart:developer';

import 'package:charity/modules/main/app.dart';
import 'package:charity/modules/main/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log(record.message, level: record.level.value, name: record.loggerName);
  });
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  await initModules(container);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const CharityApp(),
    ),
  );
}
