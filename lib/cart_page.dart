import 'package:flutter/material.dart';
import 'package:shoppingapp/product.dart';

class CartPage extends StatelessWidget {
  final List<Product> cartProducts;

  CartPage({required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartProducts[index].name),

          );
        },
      ),
    );
  }
}
