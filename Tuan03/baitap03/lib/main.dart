import 'package:flutter/material.dart';
import 'package:baitap03/product.dart';
void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bài tập 03',
      theme: ThemeData(useMaterial3: true),
      home: const ProductScreen(),
    );
  }
}


