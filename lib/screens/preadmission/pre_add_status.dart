import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tangrad/components/coffee_tile.dart';
import 'package:tangrad/constants/const.dart';
import 'package:tangrad/models/coffee.dart';
import 'package:tangrad/models/shop.dart';

class PreadmissionStatus extends StatefulWidget {
  const PreadmissionStatus({super.key});

  @override
  State<PreadmissionStatus> createState() => _PreadmissionStatusState();
}

class _PreadmissionStatusState extends State<PreadmissionStatus> {
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
                  'Pre Admission',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                StepProgressIndicator(
                  totalSteps: 6,
                  currentStep: 4,
                  size: 36,
                  selectedColor: secondaryColor,
                  unselectedColor: Colors.grey[200] ?? Colors.grey,
                  customStep: (index, color, _) => color == secondaryColor
                      ? Container(
                          color: color,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          color: color,
                          child: const Icon(
                            Icons.error,
                            color: errorColor,
                          ),
                        ),
                ),
                const CircularStepProgressIndicator(
                  totalSteps: 100,
                  currentStep: 72,
                  selectedColor: Colors.yellow,
                  unselectedColor: Colors.lightBlue,
                  padding: 0,
                  width: 100,
                  child: Icon(
                    Icons.tag_faces,
                    color: Colors.red,
                    size: 84,
                  ),
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
      ),
    );
  }
}
