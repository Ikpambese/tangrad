import 'package:flutter/material.dart';
import 'package:tangrad/models/coffee.dart';

class Coffeeshop extends ChangeNotifier {
  // All coffee for sale
  final List<Coffee> _shop = [
    Coffee(
      name: 'Long Black',
      price: '4.10',
      imageUrl: 'lib/images/c1.png',
    ),
    Coffee(
      name: 'Ginger',
      price: '4.10',
      imageUrl: 'lib/images/c2.png',
    ),
    Coffee(
      name: 'Espresso',
      price: '4.10',
      imageUrl: 'lib/images/c3.png',
    ),
    Coffee(
      name: 'Latte',
      price: '4.10',
      imageUrl: 'lib/images/c4.png',
    ),
  ];

  // User cart
  final List<Coffee> _userCart = [];

  // Get coffee list
  List<Coffee> get coffeeshop => _shop;

  List<Coffee> get userCart => _userCart;

  // Add items to cart
  void addItemsToCart(Coffee coffee) {
    // Check if the coffee is already in the cart
    var existingCoffee = _userCart.firstWhere(
      (item) => item.name == coffee.name,
      orElse: () => Coffee(name: '', price: '', imageUrl: ''),
    );

    if (existingCoffee.name.isNotEmpty) {
      // If coffee already exists in the cart, increase its quantity
      increaseQuantity(existingCoffee);
    } else {
      // Otherwise, add the coffee to the cart
      _userCart.add(coffee);
    }

    notifyListeners();
  }

  // Remove items from cart
  void removeItemsFromCart(Coffee coffee) {
    _userCart.remove(coffee);
    notifyListeners();
  }

  // Increase quantity of a coffee in the cart
  void increaseQuantity(Coffee coffee) {
    coffee.quantity++;
    notifyListeners();
  }
}
