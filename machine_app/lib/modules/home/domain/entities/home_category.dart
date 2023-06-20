import 'package:charity/modules/home/domain/entities/category.dart';
import 'package:charity/modules/home/domain/entities/item.dart';

class HomeCategory {
  final Category category;
  final List<Item> items;

  HomeCategory({
    required this.category,
    required this.items,
  });

  String get id => category.id;
  String get imageUrl => category.imageUrl;
  String get name => category.name;
}
