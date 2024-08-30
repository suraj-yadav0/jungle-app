import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
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
                        child: Image.asset('wijungle/assets/manpng.png'), // Replace with your illustration
                      ),
                    ),
                  ],
                const  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.all(8.0),
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
  const LoginForm({super.key});

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
        const  SizedBox(height: 20),
         const TextField(
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
        const  SizedBox(height: 20),
        const  TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
       const   SizedBox(height: 20),
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
       const   SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement login functionality
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.blue[900],
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
