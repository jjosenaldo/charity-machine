import 'package:charity/modules/home/data/datasources/menu_remote_datasource.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';
import 'package:charity/modules/home/domain/entities/item.dart';
import 'package:charity/modules/home/domain/repositories/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl({required this.remoteDatasource});

  final MenuRemoteDatasource remoteDatasource;

  @override
  Future<Menu> getUserMenu() {
    return remoteDatasource.getUserMenu();
  }

  @override
  Future<Item> pickItem(String itemId) {
    return remoteDatasource.pickItem(itemId);
  }
}
