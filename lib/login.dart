import 'package:flutter/material.dart';
import 'package:mood_journal/calendar.dart';
import 'package:mood_journal/signup.dart';
//TODO: import theme later

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //logo

              //message
              Text('Welcome back! Ready for another round of mental TLC?'),

              //username text entry
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Username'),
                ),
              ),

              //password text entry
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Calendar()),
                );
                } , //submission button, replace null with
                child: Text('Login'),
              ),

              //not a member? register now

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Text(
                  'New user? Sign up here.', //TODO: Add hyperlink to signup
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
