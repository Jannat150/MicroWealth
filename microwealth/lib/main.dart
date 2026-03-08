import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/welcome_screen.dart';
import 'screens/responsive_home.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/stateless_stateful_demo.dart';

void main() async {
  // Ensures Flutter is initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with platform-specific configuration
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MicroWealth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      // Start with login screen
      home: LoginScreen(),
      // Define routes for navigation
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => ResponsiveHome(),
        '/welcome': (context) => WelcomeScreen(),
        '/stateless-stateful-demo': (context) => StatelessStatefulDemo(),
      },
    );
  }
}

