import 'package:flutter/material.dart';

Widget buildItemConfirmationDialog({
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
