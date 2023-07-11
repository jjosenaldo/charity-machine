import 'package:charity/modules/main/app.dart';
import 'package:charity/modules/main/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
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
