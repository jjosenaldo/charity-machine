import 'package:charity/modules/main/data/provider_container.dart';
import 'package:charity/modules/main/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    UncontrolledProviderScope(
      container: await buildProviderContainer(),
      child: const CharityApp(),
    ),
  );
}
