import 'package:flutter/material.dart';

class ResponsiveHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("MicroWealth Dashboard"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          /// HEADER
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.05),
            color: Colors.blue,
            child: Text(
              "Welcome to MicroWealth 💰",
              style: TextStyle(
                color: Colors.white,
                fontSize: isTablet ? 30 : 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          /// MAIN CONTENT
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),

              child: isTablet
                  ? GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: buildCards(),
                    )
                  : ListView(
                      children: buildCards(),
                    ),
            ),
          ),

          /// FOOTER BUTTON
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Start Investing",
                style: TextStyle(fontSize: isTablet ? 22 : 16),
              ),
            ),
          )

        ],
      ),
    );
  }

  List<Widget> buildCards() {

    return [
      featureCard("Savings", Icons.savings),
      featureCard("Investments", Icons.trending_up),
      featureCard("Transactions", Icons.receipt),
      featureCard("Profile", Icons.person),
    ];
  }

  Widget featureCard(String title, IconData icon) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(icon, size: 50, color: Colors.blue),

            SizedBox(height: 10),

            Text(
              title,
              style: TextStyle(fontSize: 18),
            )

          ],
        ),
      ),
    );
  }
}