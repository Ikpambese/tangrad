import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tangrad/components/coffee_tile.dart';
import 'package:tangrad/constants/const.dart';
import 'package:tangrad/models/coffee.dart';
import '../../models/shop.dart';

class UploadedDocumentsPage extends StatefulWidget {
  const UploadedDocumentsPage({super.key});

  @override
  State<UploadedDocumentsPage> createState() => _UploadedDocumentsPageState();
}

class _UploadedDocumentsPageState extends State<UploadedDocumentsPage> {
  void addTocart(Coffee coffee) {
    Provider.of<Coffeeshop>(context, listen: false).addItemsToCart(coffee);
    showDialog(
      context: (context),
      builder: (context) => const AlertDialog(
        title: Text('Successfully added to documents'),
        icon: Icon(Icons.person),
      ),
    );
  }

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
                        'How would you like your coffee ?',
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
                          itemCount: value.coffeeshop.length,
                          itemBuilder: (context, index) {
                            //Get individual  coffee
                            Coffee eachCoffee = value.coffeeshop[index];
                            return CoffeeTile(
                              icon: const Icon(Icons.add),
                              coffee: eachCoffee,
                              onTap: () => addTocart(eachCoffee),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
