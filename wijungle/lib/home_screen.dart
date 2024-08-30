import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('https://mfatest.wijungle.com:9084/auth.php'),
        body: {
          'type': 'login',
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          // Successful login
          String key = responseData['key'];
          _showSuccessDialog(key);
        } else {
          // Unsuccessful login
          setState(() {
            _errorMessage = responseData['errors'] ?? 'Unknown error';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Server error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to connect to the server';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSuccessDialog(String key) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text('Login Successful'),
          content: Text('Key: $key'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/logi.png",
          fit: BoxFit.contain,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and Illustration
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (MediaQuery.of(context).size.width > 600) ...[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                              'assets/manpng.png'), // Replace with your illustration
                        ),
                      ),
                    ],
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoginForm(
                          usernameController: _usernameController,
                          passwordController: _passwordController,
                          onLogin: _login,
                          isLoading: _isLoading,
                          errorMessage: _errorMessage,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final bool isLoading;
  final String? errorMessage;

  const LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
    required this.isLoading,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's Secure Your PC",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          if (errorMessage != null)
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {
                  value != value;
                },
              ),
              Expanded(
                child: Text(
                  "By continuing, you agree to Terms & Conditions and Privacy Policy.",
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLoading ? null : onLogin,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: const Color.fromARGB(255, 45, 13, 161),
            ),
            child: isLoading ? const CircularProgressIndicator(color: Colors.black,)  : Text(
              'Log In',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
