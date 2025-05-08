import 'package:flutter/material.dart';
import 'product.dart';

class FavoritesPage extends StatelessWidget {
  final List<Product> favoriteProducts;

  FavoritesPage({required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteProducts[index].name),

          );
        },
      ),
    );
  }
}
