import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class ResponsiveHome extends StatefulWidget {
  @override
  _ResponsiveHomeState createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  
  String? userEmail;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// Load current user data from Firestore
  Future<void> _loadUserData() async {
    final user = _authService.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email;
      });

      // Get user data from Firestore
      final userData = await _firestoreService.getUserData(user.uid);
      if (userData != null && userData.exists) {
        setState(() {
          userName = userData.get('displayName') ?? user.email?.split('@')[0];
        });
      }
    }
  }

  /// Handle logout
  Future<void> _handleLogout() async {
    await _authService.logout();
    
    if (!mounted) return;
    
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("MicroWealth Dashboard"),
        centerTitle: true,
        actions: [
          // Logout button
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),

      body: Column(
        children: [

          /// HEADER - Display user info from Firestore
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.05),
            color: Colors.green,
            child: Column(
              children: [
                Text(
                  "Welcome ${userName ?? 'User'} 💰",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 30 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  userEmail ?? '',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isTablet ? 16 : 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
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
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Feature coming soon!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                "Start Investing",
                style: TextStyle(
                  fontSize: isTablet ? 22 : 16,
                  color: Colors.white,
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  List<Widget> buildCards() {

    return [
      featureCard("Savings", Icons.savings, Colors.blue),
      featureCard("Investments", Icons.trending_up, Colors.green),
      featureCard("Transactions", Icons.receipt, Colors.orange),
      featureCard("Profile", Icons.person, Colors.purple),
    ];
  }

  Widget featureCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title feature coming soon!')),
          );
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(icon, size: 50, color: color),

              SizedBox(height: 10),

              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}