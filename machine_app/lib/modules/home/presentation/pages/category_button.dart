import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onPressed,
    required this.iconColor,
  });

  final String name;
  final String imageUrl;
  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: iconColor,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        hoverColor: Colors.transparent,
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              color: Colors.white,
              imageUrl: imageUrl,
              width: 60.0,
              height: 60.0,
              errorWidget: (_, __, ___) => const SizedBox(
                child: Placeholder(),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
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
