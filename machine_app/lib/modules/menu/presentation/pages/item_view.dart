import 'package:cached_network_image/cached_network_image.dart';
import 'package:charity/modules/home/domain/entities/item.dart';
import 'package:flutter/material.dart';

const double kItemViewWidth = 200;
const double kItemViewHeight = 150;

class ItemView extends StatelessWidget {
  const ItemView({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Adjust the elevation as desired
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(8.0), // Adjust the border radius as desired
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              errorWidget: (_, __, ___) => const SizedBox(
                height: kItemViewHeight,
                child: Placeholder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8.0),
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4.0),
                if (item.allergens.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(),
                  ),
                  const SizedBox(height: 4.0),
                  Wrap(
                    spacing: 2.0,
                    children: item.allergens
                        .map((allergen) => AllergenView(
                              allergen: allergen,
                            ))
                        .toList(),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllergenView extends StatelessWidget {
  const AllergenView({super.key, required this.allergen});

  final String allergen;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        allergen,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
