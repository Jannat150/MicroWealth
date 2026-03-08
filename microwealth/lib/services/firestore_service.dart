import 'package:cloud_firestore/cloud_firestore.dart';

/// Service for handling Firestore database operations
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Add or update user data in Firestore (CREATE)
  Future<void> addUserData(String uid, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = FieldValue.serverTimestamp();
      await _db.collection('users').doc(uid).set(data, SetOptions(merge: true));
      print('User data saved successfully');
    } catch (e) {
      print('Error adding user data: $e');
      rethrow;
    }
  }

  /// Get a specific user's data (READ)
  Future<DocumentSnapshot?> getUserData(String uid) async {
    try {
      return await _db.collection('users').doc(uid).get();
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  /// Get real-time stream of users
  Stream<QuerySnapshot> getUsers() {
    return _db.collection('users').snapshots();
  }

  /// Listen to a specific user's data changes in real-time
  Stream<DocumentSnapshot> getUserStream(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }

  /// Update specific fields of user data (UPDATE)
  Future<void> updateUserData(String uid, Map<String, dynamic> updates) async {
    try {
      updates['updatedAt'] = FieldValue.serverTimestamp();
      await _db.collection('users').doc(uid).update(updates);
      print('User data updated successfully');
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }

  /// Delete a user's data from Firestore (DELETE)
  Future<void> deleteUser(String uid) async {
    try {
      await _db.collection('users').doc(uid).delete();
      print('User data deleted successfully');
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }

  /// Add a transaction/note record
  Future<void> addTransaction(String uid, Map<String, dynamic> transaction) async {
    try {
      transaction['createdAt'] = FieldValue.serverTimestamp();
      await _db
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .add(transaction);
      print('Transaction added successfully');
    } catch (e) {
      print('Error adding transaction: $e');
      rethrow;
    }
  }

  /// Get user's transactions stream
  Stream<QuerySnapshot> getTransactions(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('transactions')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
