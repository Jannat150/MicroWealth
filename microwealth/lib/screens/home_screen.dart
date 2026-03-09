import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),

      body: Center(
        child: CustomButton(
          label: "Go to Details",
          onPressed: () {
            Navigator.pushNamed(context, '/details');
          },
        ),
      ),
    );
  }
}