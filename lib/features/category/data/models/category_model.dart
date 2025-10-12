// lib/features/category/data/models/category_model.dart
import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.productCount,
    required super.createdAt,
  });
  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'],
      productCount: json['product_count'] ?? 0,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'product_count': productCount,
      'created_at': createdAt.toIso8601String(),
    };
  }
  
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      description: description,
      image: image,
      productCount: productCount,
      createdAt: createdAt,
    );
  }
}
