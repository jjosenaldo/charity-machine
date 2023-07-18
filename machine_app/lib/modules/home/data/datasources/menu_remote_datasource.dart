import 'package:charity/modules/home/domain/entities/menu.dart';

abstract class MenuRemoteDatasource {
  Future<Menu> getUserMenu();
  Future<void> pickItem(String itemId);
}
