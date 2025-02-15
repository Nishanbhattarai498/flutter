import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Update this import

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon:
                      Icon(FontAwesomeIcons.user), // Use FontAwesomeIcons
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon:
                      Icon(FontAwesomeIcons.lock), // Use FontAwesomeIcons
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Login',
                    style: TextStyle(
                        color: Colors.white)), // Ensure text is visible
              ),
            ],
          ),
        ),
      ),
    );
  }
}
