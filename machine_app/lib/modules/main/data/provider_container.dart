import 'package:charity/modules/main/module/main_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<ProviderContainer> buildProviderContainer() async {
  final container = ProviderContainer();
  await container.read(mainModuleProvider).initModules(container);

  return container;
}
