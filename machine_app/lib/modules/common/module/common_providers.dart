import 'package:charity/modules/machine/module/machine_providers.dart';
import 'package:charity/modules/home/data/datasources/impl/menu_remote_datasource_impl.dart';
import 'package:charity/modules/home/data/datasources/menu_remote_datasource.dart';
import 'package:charity/modules/home/data/repositories/menu_repository_impl.dart';
import 'package:charity/modules/home/domain/repositories/menu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuRemoteDatasourceProvider = Provider<MenuRemoteDatasource>((ref) {
  return MenuRemoteDatasourceImpl();
});

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepositoryImpl(
    remoteDatasource: ref.watch(menuRemoteDatasourceProvider),
    arduinoService: ref.watch(machineServiceProvider),
  );
});
