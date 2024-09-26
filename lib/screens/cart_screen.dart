import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tangrad/components/coffee_tile.dart';
import 'package:tangrad/constants/const.dart';
import 'package:tangrad/models/coffee.dart';
import 'package:tangrad/models/shop.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void removeFromcart(Coffee coffee) {
    Provider.of<Coffeeshop>(context, listen: false).removeItemsFromCart(coffee);
  }

  void payNow() {}
  @override
  Widget build(BuildContext context) {
    return Consumer<Coffeeshop>(
        builder: (context, value, child) => SafeArea(
              child: Scaffold(
                backgroundColor: backgroundColor,
                body: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      //heading
                      const Text(
                        'Your cart',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      // list of cofffeev
                      Expanded(
                        child: ListView.builder(
                          itemCount: value.userCart.length,
                          itemBuilder: (context, index) {
                            //Get individual  coffee
                            Coffee eachCoffee = value.userCart[index];

                            return CoffeeTile(
                              icon: const Icon(Icons.delete),
                              coffee: eachCoffee,
                              onTap: () => removeFromcart(eachCoffee),
                            );
                          },
                        ),
                      ),

                      GestureDetector(
                        onTap: payNow,
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: chocolateColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              'Pay Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
