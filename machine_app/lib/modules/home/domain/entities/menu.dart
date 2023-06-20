import 'package:charity/modules/home/domain/entities/category.dart';
import 'package:charity/modules/home/domain/entities/item.dart';

class Menu {
  final List<Category> categories;
  final List<Item> items;

  Menu({
    required this.categories,
    required this.items,
  });
}
