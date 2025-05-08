import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      Navigator.pop(context);
    });
  }
}
