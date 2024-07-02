import 'package:flutter/material.dart';
import 'package:mood_journal/calendar.dart';
import 'package:mood_journal/signup.dart';
//TODO: import theme later

String tempName = '';
String tempPassword = '';
String errorText = '';

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
              Container(
                padding: EdgeInsets.all(15),
                height: 200,
                width: 200,
                child: Image.network('https://64.media.tumblr.com/a50d0bfbda48b8444c71f2407920ac85/a1e614e28f025fc6-b8/s1280x1920/3aa6ed7c75dae3d72eb64720027264509b61995b.pnj'),
              ),
              
              //message
              Text('Welcome back! Ready for another round of mental TLC?'),

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

              ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic>? user =
                      await _queryRow(tempName, tempPassword);
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Calendar()),
                    );
                  } else {
                    //setState((){
                    errorText = "Error wrong username or password";
                    //});
                  }
                }, //submission button, replace null with
                child: Text('Login'),
              ),
              Text(
                errorText,
              ),
              /*ElevatedButton(
                onPressed: () async{
              _deleteAll();
                  
                } , //submission button, replace null with
                child: Text('delete'),
              ),*/

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

/*Future<int> _queryRow(String name, String password) async{
  await dbHelper.init();
  final row = await dbHelper.queryRow(name, password);
  if(row!= null){
    return 1;
  }else {
    return 0;
  }
}*/
Future<Map<String, dynamic>?> _queryRow(String name, String password) async {
  await dbHelper.init();
  List<Map<String, dynamic>> rows = await dbHelper.queryRow(name, password);
  return rows.isNotEmpty ? rows.first : null;
}

Future<void> _deleteAll() async {
  await dbHelper.init();
  final rowsDeleted = await dbHelper.deleteAll();
  debugPrint('deleted $rowsDeleted row(s)');
}
