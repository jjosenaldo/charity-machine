class Item {
  const Item({
    required this.id,
    required this.name,
    required this.availableQuantity,
    required this.imageUrl,
    required this.categoryId,
  });

  final String id;
  final String name;
  final int availableQuantity;
  final String imageUrl;
  final String categoryId;

  Item copyWith({
    int? availableQuantity,
  }) {
    return Item(
      id: id,
      name: name,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      imageUrl: imageUrl,
      categoryId: categoryId,
    );
  }
}
