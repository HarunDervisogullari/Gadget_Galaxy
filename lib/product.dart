
import 'package:flutter/material.dart';
import 'categories_page.dart';
import 'product.dart';

class Product {
  final String name;
  final double price;
  final List<String> features;
  final String image;
  final String category;
  final int    id;
  Product(this.name, this.price, this.features, this.image, this.category,this.id);
}
