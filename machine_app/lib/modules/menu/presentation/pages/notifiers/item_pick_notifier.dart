import 'package:charity/modules/common/presentation/charity_state.dart';
import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/home/domain/repositories/menu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemPickNotifier extends StateNotifier<CharityState<Item?>> {
  ItemPickNotifier({
    required this.repository,
  }) : super(Success(null));

  final MenuRepository repository;

  Future<void> pickItem(String itemId) async {
    state = Loading();

    try {
      // TODO: handle exceptions in the repository layer
      final newItem = await repository.pickItem(itemId);
      state = Success(newItem);
    } catch (e) {
      state = Error(
        error: e,
        message: 'Erro ao escolher o item',
      );
    }
  }
}
