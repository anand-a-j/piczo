import 'package:flutter/material.dart';
import 'package:piczo/models/user_model.dart';
import 'package:piczo/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user;

  set setUser(User userModel) {
    _user = userModel;
  }

  UserProvider() {
    refreshUser();
  }

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    print("username =${user.username}");
    _user = user;
    notifyListeners();
  }
}
