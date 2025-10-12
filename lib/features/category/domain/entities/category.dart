// lib/features/category/domain/entities/category.dart
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final int productCount;
  final DateTime createdAt;
  
  const Category({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.productCount,
    required this.createdAt,
  });
  
  @override
  List<Object?> get props => [id, name, description, image, productCount, createdAt];
}