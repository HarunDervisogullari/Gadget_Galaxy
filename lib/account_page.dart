import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late String username = '';
  late String email = '';
  late String addressName;
  late String country = '';
  late String city = '';
  late String address = '';

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    _getUserLocation();
  }

  void _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        username = userDoc['username'] ?? 'N/A';
        email = userDoc['email'] ?? 'N/A';
      });
    }
  }

  void _getUserLocation() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot locationDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        addressName = locationDoc['addressName'] ?? 'N/A';
        country = locationDoc['country'] ?? 'N/A';
        city = locationDoc['city'] ?? 'N/A';
        address = locationDoc['address'] ?? 'N/A';
      });
    }
  }

  Future<void> _editUsername() async {
    String? newUsername = '';

    newUsername = await showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Username'),
          content: TextField(
            decoration: InputDecoration(labelText: 'New Username'),
            onChanged: (value) => newUsername = value,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context, newUsername);

                User? user = FirebaseAuth.instance.currentUser;

                if (user != null && newUsername != null) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .update({'username': newUsername});


                  setState(() {
                    username = newUsername!;
                  });
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );


    if (newUsername != null) {

      setState(() {
        username = newUsername!;
      });
    }
  }

  Widget _buildGridItem(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        _onGridItemTapped(context, title);
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(8.0),
          leading: Icon(
            icon,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _onGridItemTapped(BuildContext context, String title) {
    switch (title) {
      case 'Orders':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrdersPage()),
        );
        break;
      case 'Delivery Address':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeliveryAddressPage(addressName,country, city, address),
          ),
        );
        break;
      case 'Payment Methods':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentMethodsPage()),
        );
        break;
      case 'Notifications':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationsPage()),
        );
        break;
      case 'Help':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpPage()),
        );
        break;
      case 'About':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editUsername();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 36),
                Text(
                  ' $username',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  ' $email',
                  style: TextStyle(fontSize: 18),
                ),

                _buildGridItem(context, Icons.shopping_cart, 'Orders'),
                _buildGridItem(context, Icons.location_on, 'Delivery Address'),
                _buildGridItem(context, Icons.credit_card, 'Payment Methods'),
                _buildGridItem(context, Icons.notifications, 'Notifications'),
                _buildGridItem(context, Icons.help, 'Help'),
                _buildGridItem(context, Icons.info, 'About'),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, "/login");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeliveryAddressPage extends StatelessWidget {
  final String country;
  final String city;
  final String address;
  final String addressName;
  DeliveryAddressPage(this.country, this.city, this.address,this.addressName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Address'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAddressItem('Address Name', addressName),
                _buildAddressItem('Country', country),
                _buildAddressItem('City', city),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildAddressItem('Street Address', address),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Center(
        child: Text('Orders Page Content'),
      ),
    );
  }
}

class PaymentMethodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
      ),
      body: Center(
        child: Text('Payment Methods Page Content'),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('Notifications Page Content'),
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Center(
        child: Text('Help Page Content'),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Text('About Page Content'),
      ),
    );
  }
}
