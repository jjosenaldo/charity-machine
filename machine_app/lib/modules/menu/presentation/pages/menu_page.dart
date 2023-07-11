import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/common/presentation/charity_state.dart';
import 'package:charity/modules/menu/menu_providers.dart';
import 'package:charity/modules/menu/presentation/pages/components/item_confirmation_dialog.dart';
import 'package:charity/modules/menu/presentation/pages/components/item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// TODO: add back button
class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _listenToCharityStateForSuccess(ref: ref, context: context);
    final isPicking = ref.watch(itemPickNotifierProvider) is Loading;
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

  void _listenToCharityStateForSuccess({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    ref.listen<CharityState<Item?>>(itemPickNotifierProvider, (
      CharityState<Item?>? previousState,
      CharityState<Item?> currentState,
    ) {
      if (currentState is Success<Item?> && currentState.data != null) {
        ref
            .watch(categoryItemsNotifierProvider.notifier)
            .updateItem(currentState.data!);

        showReadyForPickupDialog(context: context, ref: ref);

        // TODO: replace that with a logic to check whenever the item dispenser
        // is empty
        final navigator = Navigator.of(context);
        Future.delayed(const Duration(seconds: 8)).then((_) => navigator
            .pushNamedAndRemoveUntil('auth', (Route<dynamic> route) => false));
      }
    });
  }
}
