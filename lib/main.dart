import 'package:flutter/material.dart';
import 'package:openaiword/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Complete',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

