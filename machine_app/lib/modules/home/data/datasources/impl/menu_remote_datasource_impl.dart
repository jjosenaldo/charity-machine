import 'dart:convert';

import 'package:charity/modules/core/data/services/machine_server_http_client/machine_server_http_client_providers.dart';
import 'package:charity/modules/home/data/datasources/impl/menu_remote_datasource_impl_parsers.dart';
import 'package:charity/modules/home/data/datasources/menu_remote_datasource.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  MenuRemoteDatasourceImpl(this.ref);

  final Ref ref;
  late final _machineClient = ref.read(machineServerHttpClientProvider);

  @override
  Future<Menu> getUserMenu() async {
    return menuFromJson(
      jsonDecode(await _machineClient.get(endpoint: '/menu')),
    );
  }

  @override
  Future<void> pickItem(String itemId) {
    return _machineClient.post(endpoint: '/item/pick', body: {'id': itemId});
  }
}
