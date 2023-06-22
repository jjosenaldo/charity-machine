import 'dart:math';

import 'package:charity/modules/home/data/datasources/menu_remote_datasource.dart';
import 'package:charity/modules/home/domain/entities/category.dart';
import 'package:charity/modules/home/domain/entities/item.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';

// TODO: make actual API calls
class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  late final _items = [
    const Item(
      id: '1',
      name: 'Scrambled Eggs',
      availableQuantity: 10,
      imageUrl: 'assets/images/scrambled_eggs.jpg',
      categoryId: '1',
      machinePosition: 0,
      allergens: [],
    ),
    const Item(
      id: '2',
      name: 'Pancakes',
      availableQuantity: 5,
      imageUrl: 'assets/images/pancakes.jpg',
      categoryId: '1',
      machinePosition: 1,
      allergens: [],
    ),
    const Item(
      id: '3',
      name: 'Croissant',
      availableQuantity: 8,
      imageUrl: 'assets/images/croissant.jpg',
      categoryId: '1',
      machinePosition: 2,
      allergens: [],
    ),
    const Item(
      id: '4',
      name: 'Chicken Sandwich',
      availableQuantity: 15,
      imageUrl: 'assets/images/chicken_sandwich.jpg',
      categoryId: '2',
      machinePosition: 3,
      allergens: [],
    ),
    const Item(
      id: '5',
      name: 'Caesar Salad',
      availableQuantity: 12,
      imageUrl: 'assets/images/caesar_salad.jpg',
      categoryId: '2',
      machinePosition: 4,
      allergens: [],
    ),
    const Item(
      id: '6',
      name: 'Burger',
      availableQuantity: 7,
      imageUrl: 'assets/images/burger.jpg',
      categoryId: '2',
      machinePosition: 5,
      allergens: [],
    ),
    const Item(
      id: '7',
      name: 'Steak',
      availableQuantity: 4,
      imageUrl: 'assets/images/steak.jpg',
      categoryId: '3',
      machinePosition: 6,
      allergens: [],
    ),
    const Item(
      id: '8',
      name: 'Grilled Salmon',
      availableQuantity: 6,
      imageUrl: 'assets/images/grilled_salmon.jpg',
      categoryId: '3',
      machinePosition: 7,
      allergens: [],
    ),
    const Item(
      id: '9',
      name: 'Pasta',
      availableQuantity: 9,
      imageUrl: 'assets/images/pasta.jpg',
      categoryId: '3',
      machinePosition: 8,
      allergens: [],
    ),
  ].multiply(10);

  @override
  Future<Menu> getUserMenu() async {
    return Menu(
      categories: [
        const Category(
          id: '1',
          name: 'Breakfast',
          imageUrl:
              'https://cdn-icons-png.flaticon.com/512/17/17007.png?w=740&t=st=1687356356~exp=1687356956~hmac=a4540a55808badcd35594055e49ebb6eb209f2e155eb5ea1b6de435bae2e34ab',
          color: 0xFFFFC107,
        ),
        const Category(
          id: '2',
          name: 'Lunch',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/6540/6540381.png',
          color: 0xFF4CAF50,
        ),
        const Category(
          id: '3',
          name: 'Dinner',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/637/637129.png',
          color: 0xFF3F51B5,
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

extension _ListMultiply on List<Item> {
  List<Item> multiply(int times) {
    assert(times > 0);

    return List.generate(
      length * times,
      (index) => this[index % length].copyWith(
        allergens: _getRandomAllergens(),
        imageUrl: _getRandomImage(),
      ),
    );
  }
}

final _allAllergens = ['Lactose', 'Glúten', 'Vegano'];
List<String> _getRandomAllergens() {
  return (_allAllergens..shuffle())
      .take(Random().nextInt(_allAllergens.length + 1))
      .toList();
}

final _allImages = [
  'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Pasta_e_fagioli_rapida.jpg/800px-Pasta_e_fagioli_rapida.jpg',
  // 'https://www.costaricaguides.com/articles/images/gallo_pinto.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/e/e8/Gobi_manchurian.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg/800px-001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg',
];
String _getRandomImage() {
  return _allImages[Random().nextInt(_allImages.length)];
}
