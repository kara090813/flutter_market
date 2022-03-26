import 'package:flutter/widgets.dart';

import '../utils/logger.dart';

class UserProvider extends ChangeNotifier{
  bool _userLoggedIn = false;

  void setUserAuth(bool authState){
    _userLoggedIn = authState;
    notifyListeners();
  }

  bool get userState => _userLoggedIn;
}