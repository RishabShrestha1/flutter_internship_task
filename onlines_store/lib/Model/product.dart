import 'package:flutter/material.dart';

class Product {
  final String? id;
  final String? title;
  final double? price;
  final String? image;
  final String? description;
  Product({
    this.id,
    this.title,
    this.price,
    this.image,
    this.description,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String?,
      title: json['title'] as String?,
      price: json['price'] as double?,
      image: json['image'] as String,
      description: json['description'] as String?,
    );
  }
}
