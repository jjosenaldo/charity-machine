import 'package:charity/modules/home/domain/entities/home_category.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';

class HomeData {
  HomeData(this.categories);

  factory HomeData.empty() => HomeData([]);

  factory HomeData.fromMenu(Menu menu) {
    final categories = menu.categories
        .map((category) => HomeCategory(category: category, items: []))
        .toList();

    for (final item in menu.items) {
      final category =
          categories.firstWhere((category) => category.id == item.categoryId);
      category.items.add(item);
    }

    return HomeData(categories);
  }

  final List<HomeCategory> categories;
}
