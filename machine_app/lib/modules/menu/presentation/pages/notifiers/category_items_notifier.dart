import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryItemsNotifier extends StateNotifier<List<Item>> {
  CategoryItemsNotifier() : super([]);

  void updateItem(Item newItem) {
    final itemIndex =
        state.indexWhere((existingItem) => existingItem.id == newItem.id);

    if (itemIndex != -1) {
      if (newItem.isAvailable) {
        state[itemIndex] = newItem;
      } else {
        state.removeAt(itemIndex);
      }
    }
  }

  void setItems(List<Item> newItems) {
    state = newItems;
  }
}
