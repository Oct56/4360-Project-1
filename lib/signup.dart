import 'package:flutter/material.dart';
import 'package:mood_journal/calendar.dart';
import 'package:mood_journal/login.dart';
import 'database_helper.dart';

final dbHelper = DatabaseHelper();
//TODO: import theme later

String tempName = '';
String tempPassword = '';

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
                  onChanged: (x) {
                    tempName = x;
                  },
                ),
              ),

              //password text entry
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (x) {
                    tempPassword = x;
                  },
                ),
              ),

              //password text entry
              /*Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                ),
              ),*/

              ElevatedButton(
                onPressed: () {
                  _insert();
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
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  'Already have an account? Log in here.', //TODO: Add hyperlink to signup
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await dbHelper.init();
                  await _queryAll();
                },
                //submission button, replace null with
                child: Text('Query'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  Future<void> _insert() async {
    // Ensure the database is initialized
    await dbHelper.init();
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: tempName,
      DatabaseHelper.columnPassword: tempPassword
    };
    final id = await dbHelper.insert(row);
    debugPrint('inserted row id: $id');
    tempName = '';
    tempPassword = '';
  }
}
