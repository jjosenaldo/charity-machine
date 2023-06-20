import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onPressed,
  });

  final String name;
  final String imageUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            errorWidget: (_, __, ___) => const SizedBox(
              width: 100,
              height: 100,
              child: Placeholder(),
            ),
          ),
          SizedBox(height: 16.0),
          Text(name),
        ],
      ),
    );
  }
}
