import 'package:flutter/foundation.dart';
import '../services/user_service.dart';

class HomeViewModel extends ChangeNotifier {
  final UserService _userService;

  HomeViewModel(this._userService);

  Future<void> initializeData() async {
    await _userService.loadUsers();
  }
}
