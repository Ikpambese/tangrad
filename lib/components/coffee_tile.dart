// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  void Function() onTap;
  final int? quantity;
  final Widget icon;
  CoffeeTile(
      {super.key,
      required this.coffee,
      required this.onTap,
      this.quantity,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.grey[200]),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: ListTile(
        title: Text(coffee.name),
        subtitle: Text(coffee.price),
        leading: Image.asset(coffee.imageUrl),
        trailing: icon,
        onTap: onTap,
      ),
    );
  }
}
