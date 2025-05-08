import 'package:flutter/material.dart';
import 'home_page.dart';
import 'product.dart';
import 'categories_page.dart';

class CategoryProductsPage extends StatelessWidget {
  final Category category;

  CategoryProductsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    List<Product> categoryProducts = category.products;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(''),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: categoryProducts.length,
          itemBuilder: (context, index) {
            return ProductItem(product: categoryProducts[index]);
          },
        ),
      ),
    );
  }
}
