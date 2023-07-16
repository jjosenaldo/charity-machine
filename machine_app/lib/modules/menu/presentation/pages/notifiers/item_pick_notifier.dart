import 'package:charity/modules/home/domain/repositories/menu_repository.dart';
import 'package:charity/modules/menu/presentation/pages/notifiers/model/item_pick_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemPickNotifier extends StateNotifier<ItemPickState> {
  ItemPickNotifier({
    required this.repository,
  }) : super(ItemPickInitial());

  final MenuRepository repository;

  Future<void> pickItem(String itemId) async {
    state = PickingItem();

    try {
      await repository.pickItem(itemId);
      state = WaitingItemTake();
    } catch (e) {
      state = ItemPickError(
        error: e,
        message: 'Erro ao escolher o item',
      );
    }
  }

  void takeItem() {
    state = ItemPickInitial();
  }
}
