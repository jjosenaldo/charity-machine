import 'package:charity/modules/menu/menu_providers.dart';
import 'package:charity/modules/menu/presentation/pages/components/item_pick_dialogs.dart';
import 'package:charity/modules/menu/presentation/pages/components/item_view.dart';
import 'package:charity/modules/menu/presentation/pages/notifiers/model/item_pick_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// TODO: add back button
class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _listenCharityState(ref: ref, context: context);
    final isPicking = ref.watch(itemPickNotifierProvider) is PickingItem;
    final items = ref.watch(categoryItemsNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MasonryGridView.count(
              crossAxisCount:
                  (MediaQuery.of(context).size.width ~/ kItemViewWidth).toInt(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 14,
              itemCount: items.length,
              itemBuilder: (context, index) => ItemView(
                item: items[index],
                onPressed: () => showConfirmationDialog(
                  context: context,
                  item: items[index],
                  ref: ref,
                ),
              ),
            ),
          ),
          if (isPicking)
            const Positioned.fill(
              child: Material(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
          if (isPicking)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  void _listenCharityState({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    ref.listen<ItemPickState>(itemPickNotifierProvider, (
      ItemPickState? previousState,
      ItemPickState currentState,
    ) {
      if (ItemPickState is PickingItem) {
        showPickingItemDialog(context: context);
      } else if (ItemPickState is WaitingItemTake) {
        showReadyForTakingDialog(context: context);
      } else if (ItemPickState is ItemPickInitial) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('auth', (Route<dynamic> route) => false);
      }
    });
  }
}
