import 'package:flutter/material.dart';
import 'package:mood_journal/calendar.dart';
//TODO: import theme later

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //logo

              //message
              Text('Discover the joys of your inner world!'),

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

              //password text entry
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                ),
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Calendar()),
                );
                }, //submission button, replace null with
                child: Text('Sign Up'),
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
                  'Already have an account? Log in here.', //TODO: Add hyperlink to signup
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
