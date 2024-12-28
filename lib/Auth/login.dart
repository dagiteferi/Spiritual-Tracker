import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neh/Auth/register.dart';
import 'package:neh/Auth/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:neh/homepage/homepage.dart';
import 'package:neh/main.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key, required dataList});

  Future<void> register(
      String username,
      String password,
      BuildContext context,
      TextEditingController usernameController,
      TextEditingController passwordController) async {
    print("Attempting to register new user");

    final response = await http.post(
      Uri.parse("http://localhost:3000/user"),
      body: jsonEncode({
        'username': username,
        'pass': password,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      print("User registered successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User registered successfully')),
      );

      // Clear the form after successful registration
      usernameController.clear();
      passwordController.clear();
    } else {
      print("Failed to register user");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register user')),
      );
    }
  }

  Future<user?> login(
      String name, String password, BuildContext context) async {
    print("Attempting login");

    final response = await http.get(Uri.parse("http://localhost:3000/user"));

    if (response.statusCode == 200) {
      print("Response received with status 200");

      if (response.body.isNotEmpty) {
        var dataList = jsonDecode(response.body) as List;
        var matchedUser = dataList.map((e) => user.fromJson(e)).firstWhere(
              (user) => user.username == name && user.pass == password,
              orElse: () => user(
                  username: '',
                  email: '',
                  pass: '',
                  id: ''), // Return null if no user is found
            );

        if (matchedUser != '' && matchedUser.pass != '') {
          // Print only the username and password
          print(
              "Username: ${matchedUser.username}, Password: ${matchedUser.pass}");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          return matchedUser;
        } else {
          // Print "User not found" if no match is found
          print("User not found");

          return user(username: '', email: '', pass: '', id: '');
          // Return null if no user matches the credentials
        }
      } else {
        print("No users found in response");
        return user(username: '', email: '', pass: '', id: '');
      }
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/ll.jpg'), // Replace with your image path
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          // Login Form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                        .withOpacity(0.8), // Slightly transparent background
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                        .withOpacity(0.8), // Slightly transparent background
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    login(
                      _usernameController.text,
                      _passwordController.text,
                      context,
                    );
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    // Navigate to RegisterPage when clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 21, 41, 226)),
                  ),
                ),
                // SizedBox(height: 16.0),
                // ElevatedButton(
                //   onPressed: () {
                //     // Register new user and clear the form on success
                //     register(

                //       _usernameController.text,
                //       _passwordController.text,
                //       context,
                //       _usernameController,
                //       _passwordController,
                //     );
                //   },
                //   child: Text('Register'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
