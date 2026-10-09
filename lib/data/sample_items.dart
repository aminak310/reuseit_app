import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../models/item_model.dart';

class SampleData {
  // Categories
  static const List<CategoryModel> categories = [
    CategoryModel(
      name: 'Books',
      count: '120+ items',
      icon: Icons.menu_book_rounded,
      color: Color(0xFF4A90D9),
      bgColor: Color(0xFFEBF4FD),
    ),
    CategoryModel(
      name: 'Clothes',
      count: '85+ items',
      icon: Icons.checkroom_rounded,
      color: Color(0xFFE67E22),
      bgColor: Color(0xFFFDF0E5),
    ),
    CategoryModel(
      name: 'Electronics',
      count: '76+ items',
      icon: Icons.headphones_rounded,
      color: Color(0xFF8E44AD),
      bgColor: Color(0xFFF4EDF8),
    ),
    CategoryModel(
      name: 'Home & Living',
      count: '54+ items',
      icon: Icons.chair_rounded,
      color: Color(0xFF27AE60),
      bgColor: Color(0xFFE5F5EC),
    ),
    CategoryModel(
      name: 'Sports & Fitness',
      count: '32+ items',
      icon: Icons.sports_basketball_rounded,
      color: Color(0xFFE74C3C),
      bgColor: Color(0xFFFDEAE9),
    ),
    CategoryModel(
      name: 'Accessories',
      count: '49+ items',
      icon: Icons.watch_rounded,
      color: Color(0xFFD4A017),
      bgColor: Color(0xFFFBF5E6),
    ),
    CategoryModel(
      name: 'Beauty & Health',
      count: '21+ items',
      icon: Icons.spa_rounded,
      color: Color(0xFFE91E8C),
      bgColor: Color(0xFFFDE8F4),
    ),
    CategoryModel(
      name: 'Others',
      count: '17+ items',
      icon: Icons.more_horiz_rounded,
      color: Color(0xFF607D8B),
      bgColor: Color(0xFFECEFF1),
    ),
  ];

  // Popular items
  static const List<ItemModel> popularItems = [
    ItemModel(
      id: '1',
      name: 'Backpack',
      price: 'Rs. 1,200',
      condition: 'Good condition',
      conditionColor: AppColors.goodCondition,
      distance: '2 km away',
      category: 'Accessories',
      description:
          'Stylish and durable backpack. Used only for 6 months. No damage, just like new. Perfect for college or travel.',
      icon: Icons.backpack_rounded,
      iconColor: Color(0xFF2C3E50),
      saved: true,
      sellerName: 'Ayesha Khan',
      sellerMemberSince: '2024',
    ),
    ItemModel(
      id: '2',
      name: 'Textbook',
      price: 'Rs. 600',
      condition: 'Good condition',
      conditionColor: AppColors.goodCondition,
      distance: '1 km away',
      category: 'Books',
      description:
          'Clean textbook in excellent condition. No markings or highlight pens inside. Ready for next semester.',
      icon: Icons.menu_book_rounded,
      iconColor: Color(0xFF4A90D9),
      saved: false,
      sellerName: 'Ali Raza',
      sellerMemberSince: '2023',
    ),
    ItemModel(
      id: '3',
      name: 'Headphones',
      price: 'Rs. 800',
      condition: 'Fair condition',
      conditionColor: AppColors.fairCondition,
      distance: '3 km away',
      category: 'Electronics',
      description:
          'High quality sound with deep bass. Working perfectly fine, only minor scratches on the outer case.',
      icon: Icons.headphones_rounded,
      iconColor: Color(0xFF8E44AD),
      saved: false,
      sellerName: 'Hamza Malik',
      sellerMemberSince: '2024',
    ),
  ];

  // Clothes items
  static const List<ItemModel> clothesItems = [
    ItemModel(
      id: '4',
      name: 'Winter Jacket',
      price: 'Rs. 1,500',
      condition: 'Good condition',
      conditionColor: AppColors.goodCondition,
      distance: '2 km away',
      category: 'Clothes',
      description:
          'Warm winter jacket, worn only a couple of times. Clean and well maintained.',
      icon: Icons.checkroom_rounded,
      iconColor: Color(0xFF2C3E50),
      saved: true,
    ),
    ItemModel(
      id: '5',
      name: 'Sweatshirt',
      price: 'Rs. 800',
      condition: 'Good condition',
      conditionColor: AppColors.goodCondition,
      distance: '3 km away',
      category: 'Clothes',
      description: 'Comfortable fleece sweatshirt, size M. No stains or tears.',
      icon: Icons.checkroom_rounded,
      iconColor: Color(0xFFE74C3C),
      saved: false,
    ),
    ItemModel(
      id: '6',
      name: 'Jeans',
      price: 'Rs. 1,000',
      condition: 'Good condition',
      conditionColor: AppColors.goodCondition,
      distance: '4 km away',
      category: 'Clothes',
      description:
          'Slim-fit denim jeans in dark blue. Great condition and durable.',
      icon: Icons.dry_cleaning_rounded,
      iconColor: Color(0xFF2980B9),
      saved: false,
    ),
    ItemModel(
      id: '7',
      name: 'T-shirt',
      price: 'Rs. 400',
      condition: 'Fair condition',
      conditionColor: AppColors.fairCondition,
      distance: '5 km away',
      category: 'Clothes',
      description: 'Casual cotton t-shirt in black color. Size Large.',
      icon: Icons.dry_cleaning_rounded,
      iconColor: Color(0xFF1ABC9C),
      saved: true,
    ),
  ];
}
