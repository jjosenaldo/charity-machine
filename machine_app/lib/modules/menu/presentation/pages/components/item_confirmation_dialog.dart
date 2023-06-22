import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/menu/menu_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required Item item,
  required WidgetRef ref,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _buildItemConfirmationDialog(
      context: context,
      itemTitle: item.name,
      positiveCallback: () =>
          ref.read(itemPickNotifierProvider.notifier).pickItem(item.id),
    ),
  );
}

Widget _buildItemConfirmationDialog({
  required BuildContext context,
  required VoidCallback positiveCallback,
  required String itemTitle,
}) {
  return AlertDialog(
    title: const Text('Obter refeição'),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text('Quer obter uma unidade de $itemTitle?'),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text('Cancelar'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text('Sim'),
        onPressed: () {
          Navigator.of(context).pop();
          positiveCallback();
        },
      ),
    ],
  );
}

Future<void> showReadyForPickupDialog({
  required BuildContext context,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _buildReadyForPickupDialog(),
    barrierDismissible: false,
  );
}

Widget _buildReadyForPickupDialog() {
  return const AlertDialog(
    title: Text('Pegar refeição'),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text('Retire sua refeição da bandeja.'),
        ],
      ),
    ),
  );
}
