import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(WiJungleLoginApp());
}

class WiJungleLoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WiJungleLoginScreen(),
    );
  }
}

class WiJungleLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
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
                        child: Image.asset('assets/logo_illustration.png'), // Replace with your illustration
                      ),
                    ),
                  ],
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoginForm(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's Secure Your PC",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),
              Expanded(
                child: Text(
                  "By continuing, you agree to Terms & Conditions and Privacy Policy.",
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement login functionality
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50), backgroundColor: Colors.blue[900],
            ),
            child: Text(
              'Log In',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
