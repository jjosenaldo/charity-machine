import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/home/domain/repositories/menu_repository.dart';
import 'package:charity/modules/machine/data/service/machine_service.dart';
import 'package:charity/modules/menu/presentation/pages/notifiers/model/item_pick_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemPickNotifier extends StateNotifier<ItemPickState> {
  ItemPickNotifier({
    required this.repository,
    required this.machineService,
  }) : super(ItemPickInitial());

  final MenuRepository repository;
  final MachineService machineService;

  Future<void> pickItem(Item item) async {
    state = PickingItem();

    try {
      await repository.pickItem(item.id);
      machineService.dispenseFrom(item.machinePosition);
    } catch (e) {
      state = ItemPickError(
        error: e,
        message: 'Erro ao escolher o item',
      );
    }
  }

  void makeItemAvailable() {
    state = WaitingItemTake();
  }

  void takeItem() {
    state = ItemPickInitial();
  }
}
