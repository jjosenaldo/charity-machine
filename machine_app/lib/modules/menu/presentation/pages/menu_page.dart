import 'package:charity/modules/home/domain/entities/item.dart';
import 'package:charity/modules/menu/presentation/pages/item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key, required this.items});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MasonryGridView.count(
          crossAxisCount:
              (MediaQuery.of(context).size.width ~/ kItemViewWidth).toInt(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 14,
          itemCount: items.length,
          itemBuilder: (context, index) => ItemView(item: items[index]),
        ),
      ),
    );
  }
}
