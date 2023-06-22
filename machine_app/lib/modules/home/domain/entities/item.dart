class Item {
  const Item({
    required this.id,
    required this.name,
    required this.availableQuantity,
    required this.imageUrl,
    required this.categoryId,
    required this.machinePosition,
    required this.allergens,
  });

  final String id;
  final String name;
  final int availableQuantity;
  final String imageUrl;
  final String categoryId;
  final int machinePosition;
  final List<String> allergens;

  Item copyWith({
    int? availableQuantity,
    List<String>? allergens,
    String? imageUrl,
  }) {
    return Item(
      id: id,
      name: name,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId,
      machinePosition: machinePosition,
      allergens: allergens ?? this.allergens,
    );
  }
}
