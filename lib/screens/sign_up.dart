import 'package:flutter/material.dart';
import 'package:tangrad/components/my_text_field.dart';
import 'package:tangrad/screens/preadmission/pre_addmission.dart';
import '../components/button.dart';
import '../components/square_tile.dart';
import '../constants/const.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userPasswordcontroller = TextEditingController();

  void signUserIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreadmissionPage(),
      ),
    );
  }

//final _authService = AuthService();
  int selectedService = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  'lib/images/tangrad.jpeg',
                  height: 100,
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              // welcome back, you've been missing
              Text(
                'Welcome back you\'ve been missed',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //user name textfield
              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              // password field
              MyTextField(
                hintText: 'Password',
                obscureText: true,
                controller: userPasswordcontroller,
              ),

              const SizedBox(height: 10),
              // forgot password
              //everything centers row set to start maixis aligns to right
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              //Sign in button
              const SizedBox(height: 25),
              MyButton(
                onTap: signUserIn,
                text: "Sign Up",
                //   onPressed: () async {
                //   await _authService.signUp(
                //       _emailController.text, _passwordController.text);
                //   // Navigate to the next page
                // },
              ),
              // or continue with
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'or continue with',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                    imagePath: 'lib/images/google.png',
                  ),
                  SizedBox(width: 25),
                  SquareTile(
                    imagePath: 'lib/images/apple.png',
                  ),
                ],
              ),
              // google + sign in button

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member ?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register Now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
