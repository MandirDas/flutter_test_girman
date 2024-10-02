import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../model/model.dart';

class UserService {
  List<User> _users = [];

  Future<void> loadUsers() async {
    if (_users.isEmpty) {
      final String jsonString =
          await rootBundle.loadString('assets/user_list.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _users = jsonList.map((json) => User.fromJson(json)).toList();
    }
  }

  Future<List<User>> searchUsers(String query) async {
    await loadUsers();
    query = query.toLowerCase();
    return _users
        .where((user) =>
            user.firstName.toLowerCase().contains(query) ||
            user.lastName.toLowerCase().contains(query) ||
            user.city.toLowerCase().contains(query) ||
            user.contactNumber.contains(query))
        .toList();
  }
}
