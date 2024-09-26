import 'package:flutter/material.dart';
import 'package:tangrad/components/botton_navbar.dart';
import 'package:tangrad/constants/const.dart';
import 'package:tangrad/screens/shop_scree.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void navigateBotton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ShopScreen(),
    const Cart(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      //body: _pages[_selectedIndex],
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNav(
        onTapChange: (index) => navigateBotton(index),
      ),
    );
  }
}
