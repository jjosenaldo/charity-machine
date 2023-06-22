import 'package:charity/modules/home/data/datasources/menu_remote_datasource.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';
import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/home/domain/repositories/menu_repository.dart';

// TODO: add offline logic (cache / log file)
class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl({required this.remoteDatasource});

  final MenuRemoteDatasource remoteDatasource;

  // TODO: remove categories without available items
  @override
  Future<Menu> getUserMenu() {
    return remoteDatasource.getUserMenu();
  }

  @override
  Future<Item> pickItem(String itemId) {
    return remoteDatasource.pickItem(itemId);
  }
}
