import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neh/Auth/onboarding/onboarding.dart';
import 'package:neh/Auth/user_model.dart';
//import 'dart:convert';

void main() {
  runApp(MyApp());
  //fetchJoke();
}

Future<user> fetchJoke() async {
  print("test");
  final response = await http.get(Uri.parse("http://localhost:3000/user"));

  if (response.statusCode == 200) {
    print(response.body);
    return user.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch joke');
  }
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spiritual Tracker',
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(), // Start with OnboardingScreen
    );
  }
}
