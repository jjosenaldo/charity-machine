import 'package:charity/modules/home/data/datasources/menu_remote_datasource.dart';
import 'package:charity/modules/home/domain/entities/category.dart';
import 'package:charity/modules/home/domain/entities/item.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';

// TODO: make actual API calls
class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  final _items = [
    const Item(
      id: '1',
      name: 'Scrambled Eggs',
      availableQuantity: 10,
      imageUrl: 'assets/images/scrambled_eggs.jpg',
      categoryId: '1',
    ),
    const Item(
      id: '2',
      name: 'Pancakes',
      availableQuantity: 5,
      imageUrl: 'assets/images/pancakes.jpg',
      categoryId: '1',
    ),
    const Item(
      id: '3',
      name: 'Croissant',
      availableQuantity: 8,
      imageUrl: 'assets/images/croissant.jpg',
      categoryId: '1',
    ),
    const Item(
      id: '4',
      name: 'Chicken Sandwich',
      availableQuantity: 15,
      imageUrl: 'assets/images/chicken_sandwich.jpg',
      categoryId: '2',
    ),
    const Item(
      id: '5',
      name: 'Caesar Salad',
      availableQuantity: 12,
      imageUrl: 'assets/images/caesar_salad.jpg',
      categoryId: '2',
    ),
    const Item(
      id: '6',
      name: 'Burger',
      availableQuantity: 7,
      imageUrl: 'assets/images/burger.jpg',
      categoryId: '2',
    ),
    const Item(
      id: '7',
      name: 'Steak',
      availableQuantity: 4,
      imageUrl: 'assets/images/steak.jpg',
      categoryId: '3',
    ),
    const Item(
      id: '8',
      name: 'Grilled Salmon',
      availableQuantity: 6,
      imageUrl: 'assets/images/grilled_salmon.jpg',
      categoryId: '3',
    ),
    const Item(
      id: '9',
      name: 'Pasta',
      availableQuantity: 9,
      imageUrl: 'assets/images/pasta.jpg',
      categoryId: '3',
    ),
  ];

  @override
  Future<Menu> getUserMenu() async {
    await Future.delayed(const Duration(seconds: 2));
    return Menu(
      categories: [
        const Category(
          id: '1',
          name: 'Breakfast',
          imageUrl: 'assets/images/breakfast.jpg',
        ),
        const Category(
          id: '2',
          name: 'Lunch',
          imageUrl: 'assets/images/lunch.jpg',
        ),
        const Category(
          id: '3',
          name: 'Dinner',
          imageUrl: 'assets/images/dinner.jpg',
        ),
      ],
      items: _items,
    );
  }

  @override
  Future<Item> pickItem(String itemId) async {
    final itemIndex = _items.indexWhere((item) => item.id == itemId);
    final oldItem = _items[itemIndex];
    final newItem = oldItem.copyWith(
      availableQuantity: oldItem.availableQuantity - 1,
    );

    if (newItem.availableQuantity == 0) {
      _items.removeAt(itemIndex);
    } else {
      _items[itemIndex] = newItem;
    }

    return newItem;
  }
}
