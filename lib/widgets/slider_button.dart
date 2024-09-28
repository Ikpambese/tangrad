import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

class SliderButto extends StatelessWidget {
  const SliderButto({super.key});

  @override
  Widget build(BuildContext context) {
    return SliderButton(
      action: () async {
        ///Do something here OnSlide
        return true;
      },

      ///Put label over here
      label: Text(
        "Slide to upload !",
        style: TextStyle(
            color: Color(0xff4a4a4a),
            fontWeight: FontWeight.w500,
            fontSize: 17),
      ),
      icon: Center(
          child: Icon(
        Icons.upload,
        color: Colors.white,
        size: 40.0,
        semanticLabel: 'Text to announce in accessibility modes',
      )),

      ///Change All the color and size from here.
      width: 270,
      radius: 10,
      buttonColor: Color.fromARGB(255, 6, 69, 40),
      backgroundColor: Color.fromARGB(255, 206, 223, 215),
      highlightedColor: Colors.white,
      baseColor: Colors.red,
    );
  }
}
