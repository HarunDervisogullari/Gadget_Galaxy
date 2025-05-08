import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/cart_provider.dart';
import 'cart_page.dart';
import 'categories_page.dart';
import 'product.dart';
import 'account_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'product_details_page.dart';
import 'favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'payment_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Product> products = CategoryGrid().getAllProducts();
  List<Product> displayedProducts = [];

  List<String> carouselImages = [
    'assets/category_images/newyear.png',
    'assets/category_images/offer.png',
    'assets/category_images/sale.png',
  ];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    products.shuffle();
    displayedProducts = List.from(products);
  }

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(100.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchTextChanged,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.location_on),
              color: Colors.blueGrey,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LocationInputDialog();
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              color: Colors.blueGrey,
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 170.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: carouselImages.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(''),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      return ProductItem(product: displayedProducts[index]);
                    },
                  ),
                ),
                SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 24.0,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        onTap: (index) {
          _onBottomNavigationBarTapped(index);
        },
      ),
    );
  }

  void onSearchTextChanged(String query) {
    setState(() {
      displayedProducts = products
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onBottomNavigationBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoriesPage(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavoritesPage(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountPage(),
          ),
        );
        break;
    }
  }
}

class LocationInputDialog extends StatefulWidget {
  const LocationInputDialog({Key? key}) : super(key: key);

  @override
  _LocationInputDialogState createState() => _LocationInputDialogState();
}

class _LocationInputDialogState extends State<LocationInputDialog> {
  TextEditingController addressNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Location'),
      contentPadding: EdgeInsets.all(16.0),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: addressNameController,
              decoration: InputDecoration(labelText: 'Address Name'),
            ),
            TextField(
              controller: countryController,
              decoration: InputDecoration(labelText: 'Country'),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Street Address'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            User? user = FirebaseAuth.instance.currentUser;

            if (user != null &&
                addressNameController.text.isNotEmpty &&
                countryController.text.isNotEmpty &&
                cityController.text.isNotEmpty &&
                addressController.text.isNotEmpty) {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .update({
                'addressName': addressNameController.text,
                'country': countryController.text,
                'city': cityController.text,
                'address': addressController.text,
              });

              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please fill in all fields.'),
                ),
              );
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}


class ProductItem extends StatefulWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late FavoriteProvider favoriteProvider;
  late CartProvider cartProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    favoriteProvider = Provider.of<FavoriteProvider>(context);
    cartProvider = Provider.of<CartProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite =
    favoriteProvider.favoriteProductIds.contains(widget.product.id);
    bool isAddedToCart =
    cartProvider.cartProductIds.contains(widget.product.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: widget.product),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.product.price.toString()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            color: isFavorite ? Colors.red : Colors.grey,
                            onPressed: () {
                              favoriteProvider.toggleFavorite(widget.product.id);
                            },
                          ),
                          if (isAddedToCart)
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {

                                cartProvider.toggleFavorite(widget.product.id);
                              },
                            ),
                          if (!isAddedToCart)
                            IconButton(
                              icon: Icon(Icons.add_shopping_cart),
                              color: Colors.grey,
                              onPressed: () {

                                cartProvider.toggleFavorite(widget.product.id);
                                Fluttertoast.showToast(
                                  msg: 'Product added to the cart',
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.purple,
                                  textColor: Colors.white,
                                );
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider =
    Provider.of<FavoriteProvider>(context);

    Set<int> favoriteProductIds = favoriteProvider.favoriteProductIds;

    List<Product> favoriteProducts = CategoryGrid()
        .getAllProducts()
        .where((product) => favoriteProductIds.contains(product.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favoriteProducts.isEmpty
          ? Center(
        child: Text('No favorite products yet.'),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          return ProductItem(product: favoriteProducts[index]);
        },
      ),
    );
  }
}


class PriceUtils {
  static double calculateTotalPrice(List<Product> products) {
    return products.fold(
      0.0,
          (previousValue, product) => previousValue + product.price,
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Set<int> cartProductIds = cartProvider.cartProductIds;

    List<Product> cartProducts = CategoryGrid()
        .getAllProducts()
        .where((product) => cartProductIds.contains(product.id))
        .toList();

    double totalPrice = PriceUtils.calculateTotalPrice(cartProducts);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        backgroundColor: Colors.purple,
      ),
      body: cartProducts.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 150.0,
              backgroundColor: Colors.grey[200],
              child: Image.asset(
                'assets/category_images/mycart.png',
                fit: BoxFit.cover,
                width: 250.0,
                height: 250.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text('There are currently no items in the cart.'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Return to shopping'),
            ),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                return CartProductItem(product: cartProducts[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentPage(totalPrice: totalPrice),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Pay Now'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class CartProductItem extends StatelessWidget {
  final Product product;

  CartProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(product.id.toString()),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30.0,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
      ),
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .toggleFavorite(product.id);
      },
      child: ProductItem(product: product),
    );
  }
}


class PaymentPage extends StatelessWidget {
  final double totalPrice;

  PaymentPage({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardNumberInput(),
            SizedBox(height: 16.0),
            _buildExpirationDateInput(),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                if (_validateInputs()) {
                  _showOrderReceivedToast(context);
                  _navigateToHomePageAfterDelay(context);
                } else {
                  Fluttertoast.showToast(
                    msg: 'Please fill in both card number and expiration date correctly',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                backgroundColor: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Pay   \$${totalPrice.toStringAsFixed(2)}'),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Save Card Information'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardNumberInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Card Number',
        hintText: '0000 0000 0000 0000',
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      keyboardType: TextInputType.number,
      maxLength: 16,
      inputFormatters: [

      ],
    );
  }

  Widget _buildExpirationDateInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Expiration Date',
        hintText: 'MM/YY',
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      keyboardType: TextInputType.number,
      maxLength: 5,
      inputFormatters: [

      ],
    );
  }

  bool _validateInputs() {


    return true;
  }

  void _showOrderReceivedToast(BuildContext context) {
    Fluttertoast.showToast(
      msg: 'Your order has been received. It will be shipped to you as soon as possible.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _navigateToHomePageAfterDelay(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
      );
    });
  }
}
