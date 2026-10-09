import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ItemModel {
  final String id;
  final String name;
  final String price;
  final String condition;
  final Color conditionColor;
  final String distance;
  final String category;
  final String description;
  final IconData icon;
  final Color iconColor;
  final bool saved;
  final String sellerName;
  final String sellerMemberSince;
  final List<String>? images;

  const ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.condition,
    this.conditionColor = AppColors.goodCondition,
    required this.distance,
    required this.category,
    this.description = '',
    required this.icon,
    this.iconColor = AppColors.textDark,
    this.saved = false,
    this.sellerName = 'Ayesha Khan',
    this.sellerMemberSince = '2024',
    this.images,
  });

  ItemModel copyWith({
    String? id,
    String? name,
    String? price,
    String? condition,
    Color? conditionColor,
    String? distance,
    String? category,
    String? description,
    IconData? icon,
    Color? iconColor,
    bool? saved,
    String? sellerName,
    String? sellerMemberSince,
    List<String>? images,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      condition: condition ?? this.condition,
      conditionColor: conditionColor ?? this.conditionColor,
      distance: distance ?? this.distance,
      category: category ?? this.category,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      saved: saved ?? this.saved,
      sellerName: sellerName ?? this.sellerName,
      sellerMemberSince: sellerMemberSince ?? this.sellerMemberSince,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'condition': condition,
      'conditionColor': conditionColor,
      'distance': distance,
      'category': category,
      'description': description,
      'icon': icon,
      'iconColor': iconColor,
      'saved': saved,
      'sellerName': sellerName,
      'sellerMemberSince': sellerMemberSince,
      'images': images,
    };
  }
}

class CategoryModel {
  final String name;
  final String count;
  final IconData icon;
  final Color color;
  final Color bgColor;

  const CategoryModel({
    required this.name,
    required this.count,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}
