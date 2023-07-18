import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/home/domain/entities/category.dart';
import 'package:charity/modules/home/domain/entities/category_status.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';

CategoryStatus categoryStatusFromJson(int statusIndex) {
  if (statusIndex < 0 || statusIndex >= CategoryStatus.values.length) {
    throw Exception();
  }
  return CategoryStatus.values[statusIndex];
}

Category categoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'],
    name: json['name'],
    imageUrl: json['imageUrl'],
    color: json['color'],
    status: categoryStatusFromJson(json['status']),
  );
}

Item itemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'],
    name: json['name'],
    availableQuantity: json['availableQuantity'],
    imageUrl: json['imageUrl'],
    categoryId: json['categoryId'],
    machinePosition: json['machinePosition'],
    allergens: List<String>.from(json['allergens']),
  );
}

Menu menuFromJson(Map<String, dynamic> json) {
  return Menu(
    categories: List<Category>.from(json['categories']
        .map((categoryJson) => categoryFromJson(categoryJson))),
    items: List<Item>.from(
        json['items'].map((itemJson) => itemFromJson(itemJson))),
  );
}
