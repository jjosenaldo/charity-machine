import 'package:charity/modules/home/domain/entities/category_status.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;
  final int color;
  final CategoryStatus status;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.status,
  });

  bool get isAvailable => status == CategoryStatus.available;

  Category copyWith({CategoryStatus? status}) {
    return Category(
      id: id,
      name: name,
      imageUrl: imageUrl,
      color: color,
      status: status ?? this.status,
    );
  }
}
