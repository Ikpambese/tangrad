import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/shop.dart';
import 'screens/splash/splash.dart';

//import 'package:teeorcofee/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Coffeeshop(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
