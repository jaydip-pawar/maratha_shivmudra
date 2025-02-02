import 'package:flutter/material.dart';
import 'package:maratha_shivmudra/core/base/base_widget/stateless/stateless_base.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
