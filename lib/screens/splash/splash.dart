import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:tangrad/screens/sign_up.dart';

import '../../constants/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_controller);

    _controller.repeat();

    //  Navigate after 5 secs
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SignUpScreen(),
          //HomeScreen()
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Transform(
                  //   alignment: Alignment.center,
                  //   transform: Matrix4.identity()
                  //     ..rotateY(
                  //       _animation.value,
                  //     ),
                  //   child: Container(
                  //     width: 100,
                  //     height: 100,
                  //     decoration: BoxDecoration(
                  //       color: chocolateColor,
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.5),
                  //           spreadRadius: 5,
                  //           blurRadius: 7,
                  //           offset: const Offset(0, 3),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Container(
                    child: Image.asset(
                      'lib/images/tangrad.jpeg',
                      height: 40,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 100.0,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Agne',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('Loading...',
                              textStyle:
                                  const TextStyle(color: chocolateColor)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
