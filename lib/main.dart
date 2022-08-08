import 'package:flutter/material.dart';
import 'package:orange_valley_caa/pages/home_page.dart';

void main() {
  runApp(const OrangeValleyApp());
}

class OrangeValleyApp extends StatelessWidget {
  const OrangeValleyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
