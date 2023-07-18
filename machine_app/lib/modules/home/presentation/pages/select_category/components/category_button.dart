import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onPressed,
    required this.iconColor,
    required this.enabled,
  });

  final String name;
  final String imageUrl;
  final VoidCallback onPressed;
  final Color iconColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textColor =
        enabled ? Colors.white : const Color.fromRGBO(183, 183, 183, 1);

    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: enabled ? iconColor : const Color.fromRGBO(229, 229, 229, 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        hoverColor: Colors.transparent,
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              color: textColor,
              imageUrl: imageUrl,
              width: 60.0,
              height: 60.0,
              errorWidget: (_, __, ___) => const SizedBox(
                child: Placeholder(),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              name,
              style: TextStyle(
                color: textColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
