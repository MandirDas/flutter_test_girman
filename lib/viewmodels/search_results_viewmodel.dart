import 'package:flutter/foundation.dart';
// import '../services/user_service.dart';
import '../model/model.dart';
import '../services/firebase_service.dart';

class SearchResultsViewModel extends ChangeNotifier {
  //for local
  // final UserService _userService;
  //for firebase
  final FirebaseService _firebaseService;
  List<User> _searchResults = [];
  bool _isLoading = false;

  // SearchResultsViewModel(this._userService);
  SearchResultsViewModel(this._firebaseService);

  List<User> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> searchUsers(String query) async {
    _isLoading = true;
    notifyListeners();

    // _searchResults = await _userService.searchUsers(query);

    try {
      _searchResults = await _firebaseService.searchUsers(query);
    } catch (e) {
      print('Error searching users: $e');
      _searchResults = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearResults() {
    _searchResults = [];
    notifyListeners();
  }
}
