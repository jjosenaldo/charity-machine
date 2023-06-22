import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';

abstract class MenuRemoteDatasource {
  Future<Menu> getUserMenu();
  Future<Item> pickItem(String itemId);
}
