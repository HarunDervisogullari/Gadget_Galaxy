import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'toast.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendPasswordResetEmail();
              },
              child: Text("Send Email"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendPasswordResetEmail() async {
    String email = _emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showToast(message: "Password reset email sent to $email");
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());

      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          showToast(message: "No user found with this email");
        } else {
          showToast(message: "Failed to send password reset email");
        }
      }
    }
  }
}
