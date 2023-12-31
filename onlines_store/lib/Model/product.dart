// ignore: unused_import
import 'package:flutter/material.dart';

class Product {
  final int? id;
  final String? title;
  final double? price;
  final String? image;
  final String? description;
  final String? category;
  Product({
    this.id,
    this.title,
    this.price,
    this.image,
    this.description,
    this.category,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      title: json['title'] as String?,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'] as double?,
      image: json['image'] as String,
      category: json['category'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'description': description,
      'category': category,
    };
  }
}
