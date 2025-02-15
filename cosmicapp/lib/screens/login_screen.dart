import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cosmicapp/providers/auth_provider.dart';
import 'package:cosmicapp/screens/home_screen.dart';
import 'package:cosmicapp/widgets/cosmic_button.dart';
import 'package:cosmicapp/widgets/cosmic_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await Provider.of<AuthProvider>(context, listen: false)
          .login(_emailController.text, _passwordController.text);

      if (success && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1539721972319-f0e80a00d424',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.4),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'cosmic',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CosmicTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 16),
                    CosmicTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    CosmicButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text('Sign In',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.yellowAccent),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialButton(
                          icon: 'assets/icons/google.png',
                          onPressed: () {},
                        ),
                        const SizedBox(width: 16),
                        _SocialButton(
                          icon: 'assets/icons/facebook.png',
                          onPressed: () {},
                        ),
                        const SizedBox(width: 16),
                        _SocialButton(
                          icon: 'assets/icons/apple.png',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(icon),
      ),
    );
  }
}
