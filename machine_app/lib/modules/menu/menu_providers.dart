import 'package:charity/modules/common/common_providers.dart';
import 'package:charity/modules/common/presentation/charity_state.dart';
import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/menu/presentation/pages/notifiers/item_pick_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/pages/notifiers/category_items_notifier.dart';

final itemPickNotifierProvider =
    StateNotifierProvider<ItemPickNotifier, CharityState<Item?>>((ref) {
  return ItemPickNotifier(
    repository: ref.watch(menuRepositoryProvider),
  );
});

final categoryItemsNotifierProvider =
    StateNotifierProvider<CategoryItemsNotifier, List<Item>>((ref) {
  return CategoryItemsNotifier();
});
