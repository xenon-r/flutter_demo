import 'package:flutter_demo/core/models/user.dart';
import 'package:flutter_demo/core/scoped_models/base_model.dart';
import 'package:flutter_demo/utils/database_helper.dart';

class LoginModel extends BaseModel {
  User user = new User();
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  void setEmail(value) {
    user.email = value;
    notifyListeners();
  }

  String getEmail() {
    if (user.email != null) {
      return user.email;
    } else
      return 'empty';
  }

  String getPassword() {
    if (user.password != null) {
      return user.password;
    } else
      return 'empty';
  }

  Future<int> login() async {
    return await _databaseHelper.isRegistered(user.email, user.password);
  }

  void setPassword(value) {
    user.password = value;
    notifyListeners();
  }
}
