import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),

      body: Center(
        child: CustomButton(
          label: "Go Back",
          color: Colors.orange,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}