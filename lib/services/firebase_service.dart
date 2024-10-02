// import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test_girman_tech/model/model.dart';
// import 'package:flutter_test_girman_tech/model/model.dart';

class FirebaseService {
  final DatabaseReference _database;

  FirebaseService()
      : _database = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://girman-test-default-rtdb.asia-southeast1.firebasedatabase.app/',
        ).ref();

  Future<List<User>> getUsers() async {
    try {
      print("Attempting to fetch users from Firebase");
      print("Database reference: ${_database.path}");

      DataSnapshot snapshot = await _database.get();
      print("Snapshot received. Has value: ${snapshot.value != null}");

      if (snapshot.value == null) {
        print("Snapshot value is null. Returning empty list.");
        return [];
      }

      if (snapshot.value is! Map) {
        print(
            "Snapshot value is not a Map. Type: ${snapshot.value.runtimeType}");
        return [];
      }

      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      print("Number of items in snapshot: ${values.length}");

      List<User> users = [];
      values.forEach((key, value) {
        print("Processing user with key: $key");
        try {
          users.add(User.fromJson(value));
          print("User added successfully");
        } catch (e) {
          print("Error processing user $key: $e");
        }
      });

      print("Fetched ${users.length} users");
      return users;
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }

  Future<List<User>> searchUsers(String query) async {
    try {
      print('Attempting to search users with query: $query');
      DataSnapshot snapshot = await _database.get();

      if (snapshot.value == null) {
        print('No data found in the database');
        return [];
      }

      print('Snapshot value type: ${snapshot.value.runtimeType}');

      if (snapshot.value is! List) {
        print('Data is not a List. Actual type: ${snapshot.value.runtimeType}');
        return [];
      }

      List<dynamic> valuesList = snapshot.value as List<dynamic>;
      print('Data is a List. Length: ${valuesList.length}');

      List<User> users = valuesList
          .where((item) => item != null && item is Map<Object?, Object?>)
          .map((item) {
            // Convert Map<Object?, Object?> to Map<String, dynamic>
            Map<String, dynamic> userMap =
                Map<String, dynamic>.from(item as Map);
            return User.fromJson(userMap);
          })
          .where((user) =>
              user.firstName.toLowerCase().contains(query.toLowerCase()) ||
              user.lastName.toLowerCase().contains(query.toLowerCase()))
          .toList();

      print('Found ${users.length} users matching the query');
      return users;
    } catch (e) {
      print('Error searching users: $e');
      return [];
    }
  }
}
