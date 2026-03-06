import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  bool clicked = false;

  void changeText(){
    setState(() {
      clicked = !clicked;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("MicroWealth App"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              clicked ? "Welcome to MicroWealth 💰" : "Hello User 👋",
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 20),

            Icon(
              Icons.account_balance_wallet,
              size: 100,
              color: Colors.green,
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: changeText,
              child: Text("Click Me"),
            )

          ],
        ),
      ),
    );
  }
}