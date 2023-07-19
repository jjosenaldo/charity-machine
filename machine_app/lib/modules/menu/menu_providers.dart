import 'package:charity/modules/common/module/common_providers.dart';
import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/machine/module/machine_providers.dart';
import 'package:charity/modules/menu/presentation/pages/notifiers/item_pick_notifier.dart';
import 'package:charity/modules/menu/presentation/pages/notifiers/model/item_pick_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/pages/notifiers/category_items_notifier.dart';

final itemPickNotifierProvider =
    StateNotifierProvider<ItemPickNotifier, ItemPickState>((ref) {
  return ItemPickNotifier(
    repository: ref.watch(menuRepositoryProvider),
    machineService: ref.watch(machineServiceProvider),
  );
});

final categoryItemsNotifierProvider =
    StateNotifierProvider<CategoryItemsNotifier, List<Item>>((ref) {
  return CategoryItemsNotifier();
});
