class Category {
  final String id;
  final String name;
  final String imageUrl;
  final int color;
  final bool available;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.available,
  });

  Category copyWith({bool? available}) {
    return Category(
      id: id,
      name: name,
      imageUrl: imageUrl,
      color: color,
      available: available ?? this.available,
    );
  }
}
