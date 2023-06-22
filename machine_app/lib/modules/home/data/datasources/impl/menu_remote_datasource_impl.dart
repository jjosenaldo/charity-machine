import 'dart:math';

import 'package:charity/modules/home/data/datasources/menu_remote_datasource.dart';
import 'package:charity/modules/home/domain/entities/category.dart';
import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';

// TODO: make actual API calls
class MenuRemoteDatasourceImpl implements MenuRemoteDatasource {
  late final _categories = [
    const Category(
      id: '1',
      name: 'Café-da-manhã',
      imageUrl:
          'https://cdn-icons-png.flaticon.com/512/17/17007.png?w=740&t=st=1687356356~exp=1687356956~hmac=a4540a55808badcd35594055e49ebb6eb209f2e155eb5ea1b6de435bae2e34ab',
      color: 0xFFFFC107,
    ),
    const Category(
      id: '2',
      name: 'Almoço',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/6540/6540381.png',
      color: 0xFF4CAF50,
    ),
    const Category(
      id: '3',
      name: 'Jantar',
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/637/637129.png',
      color: 0xFF3F51B5,
    ),
  ];
  List<Item> _items = [];

  @override
  Future<Menu> getUserMenu() async {
    _items = _generateRandomItems();

    return Menu(
      categories: _categories,
      items: _items,
    );
  }

  @override
  Future<Item> pickItem(String itemId) async {
    await Future.delayed(const Duration(seconds: 1));
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

  List<Item> _generateRandomItems() {
    return List.generate(
      30,
      (_) => Item(
        id: _getNextId(),
        allergens: _getRandomAllergens(),
        availableQuantity: _getRandomAvailableQuantity(),
        imageUrl: _getRandomImage(),
        categoryId: _getRandomCategory().id,
        machinePosition: _getNextMachinePosition(),
        name: _getRandomItemName(),
      ),
    );
  }

  int _itemId = 0;
  String _getNextId() {
    return (_itemId++).toString();
  }

  int _machinePosition = 0;
  int _getNextMachinePosition() {
    return _machinePosition++;
  }

  final _allAllergens = [
    'Lactose',
    'Glúten',
    'Vegano',
    'Sódio',
  ];
  List<String> _getRandomAllergens() {
    return (_allAllergens..shuffle())
        .take(Random().nextInt(_allAllergens.length + 1))
        .toList();
  }

  final _allImages = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Pasta_e_fagioli_rapida.jpg/800px-Pasta_e_fagioli_rapida.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/e/e8/Gobi_manchurian.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/1/13/Uszka-aasica.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg/800px-001_Tacos_de_carnitas%2C_carne_asada_y_al_pastor.jpg',
  ];
  String _getRandomImage() {
    return _allImages[Random().nextInt(_allImages.length)];
  }

  final _allItemNames = [
    'Ovo',
    'Panqueca',
    'Croissant',
    'Sanduíche de frango',
    'Salada César',
    'Hamburger',
    'Bife',
    'Salmão grelhado',
    'Macarrão',
  ];
  String _getRandomItemName() {
    return _allItemNames[Random().nextInt(_allItemNames.length)];
  }

  int _getRandomAvailableQuantity() {
    return Random().nextInt(5) + 1;
  }

  Category _getRandomCategory() {
    return _categories[Random().nextInt(_categories.length)];
  }
}
