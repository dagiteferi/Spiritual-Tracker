import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neh/Auth/login.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  RegisterPage({super.key});

  // Register function with enhanced error handling
  Future<void> register(String fullName, String email, String phone,
      String username, String password, BuildContext context) async {
    print("Attempting to register new user");

    final String url =
        "http://localhost:3000/user"; // Replace <your_local_ip> with your local IP

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'username': username,
          'pass': password,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 201) {
        // Registration successful
        print("User registered successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User registered successfully')),
        );
        // Navigate to LoginPage after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage(dataList: null)),
        );
      } else {
        // Handle server errors or invalid responses
        print("Failed to register user. Status: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register user. Please try again.')),
        );
      }
    } catch (error) {
      // Network errors
      print("Error occurred: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Stack(
        children: <Widget>[
          // Background Image with dark overlay
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/register_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black
                  .withOpacity(0.6), // Dark overlay for better contrast
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                // Title
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.0),

                // Full Name Field
                _buildTextField(
                  controller: _fullNameController,
                  label: 'Full Name',
                  keyboardType: TextInputType.name,
                  icon: Icons.person,
                ),
                SizedBox(height: 16.0),

                // Email Field
                _buildTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                ),
                SizedBox(height: 16.0),

                // Phone Number Field
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone,
                ),
                SizedBox(height: 16.0),

                // Username Field
                _buildTextField(
                  controller: _usernameController,
                  label: 'Username',
                  keyboardType: TextInputType.text,
                  icon: Icons.account_circle,
                ),
                SizedBox(height: 16.0),

                // Password Field
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  icon: Icons.lock,
                ),
                SizedBox(height: 24.0),

                // Register Button
                ElevatedButton(
                  onPressed: () {
                    // Validate inputs before proceeding
                    if (_fullNameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _phoneController.text.isEmpty ||
                        _usernameController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      // Show a warning if any field is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields')),
                      );
                    } else {
                      // Register the user and navigate to login page
                      register(
                        _fullNameController.text,
                        _emailController.text,
                        _phoneController.text,
                        _usernameController.text,
                        _passwordController.text,
                        context,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(height: 16.0),

                // Skip Registration Button
                TextButton(
                  onPressed: () {
                    // Skip registration and go to LoginPage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(dataList: null)),
                    );
                  },
                  child: Text(
                    'Already have an account? Go to Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Custom TextField Widget to avoid code repetition
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    required TextInputType keyboardType,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        prefixIcon: Icon(icon, color: Colors.white70),
        contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      ),
    );
  }
}
