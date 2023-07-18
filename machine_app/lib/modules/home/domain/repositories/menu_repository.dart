import 'package:charity/modules/home/domain/entities/menu.dart';

abstract class MenuRepository {
  Future<Menu> getUserMenu();
  Future<void> pickItem(String itemId);
}
