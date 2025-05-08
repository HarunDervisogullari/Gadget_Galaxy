import 'package:flutter/material.dart';
import 'product.dart';




class ProductDetailsPage extends StatefulWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavorite = false;
  bool isAdd=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          widget.product.name,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [

          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: isFavorite ? Colors.red : Colors.grey,
            onPressed: () {

              setState(() {
                isFavorite = !isFavorite;
              });

            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.product.image,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),

            Row(
              children: [
                Text(
                  'Price: \$${widget.product.price.toString()}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {

                  },
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'Features:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.product.features.map((feature) {
                return Text('- $feature');
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
