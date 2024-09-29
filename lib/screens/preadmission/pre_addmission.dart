import 'package:flutter/material.dart';
import 'package:tangrad/components/botton_navbar.dart';
import 'package:tangrad/constants/const.dart';
import 'package:tangrad/screens/preadmission/shop_scree.dart';

import 'cart_screen.dart';

class PreadmissionPage extends StatefulWidget {
  const PreadmissionPage({super.key});

  @override
  State<PreadmissionPage> createState() => _PreadmissionPageState();
}

class _PreadmissionPageState extends State<PreadmissionPage> {
  int _selectedIndex = 0;

  void navigateBotton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const UploadedDocumentsPage(),
    const PreadmissionStatus(),
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
