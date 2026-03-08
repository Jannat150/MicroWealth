import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

/// Service for handling Firebase Authentication
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Listen to authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign up a new user with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      // Force use of emulator-friendly settings
      _auth.setSettings(
        appVerificationDisabledForTesting: true,
        forceRecaptchaFlow: false,
      );
      
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on SocketException catch (e) {
      print('Network Error: No internet connection - $e');
      throw Exception('No internet connection. Please check your network.');
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      if (e.code == 'weak-password') {
        throw Exception('Password must be at least 6 characters');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('This email is already registered. Try logging in instead.');
      } else if (e.code == 'network-request-failed') {
        throw Exception('Network error. Check your internet connection.');
      } else if (e.code == 'invalid-email') {
        throw Exception('Invalid email address');
      } else {
        throw Exception(e.message ?? 'Signup failed');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      print('Unexpected error: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  /// Log in an existing user with email and password
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Error: No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Error: Wrong password provided.');
      } else {
        print('Error: ${e.message}');
      }
      return null;
    } catch (e) {
      print('Unexpected error: $e');
      return null;
    }
  }

  /// Log out the current user
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  /// Send password reset email
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print('Error sending password reset email: $e');
      return false;
    }
  }
}
