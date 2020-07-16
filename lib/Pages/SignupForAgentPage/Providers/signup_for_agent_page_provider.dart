import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupForAgentPageProvider extends ChangeNotifier {
  static SignupForAgentPageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<SignupForAgentPageProvider>(context, listen: listen);

  void refresh() {
    notifyListeners();
  }

  String _confirmPassword;
  String get confirmPassword => _confirmPassword;
  void setConfirmPassword(String confirmPassword) {
    if (_confirmPassword != confirmPassword) {
      _confirmPassword = confirmPassword;
      notifyListeners();
    }
  }

  String _errorString = "";
  String get errorString => _errorString;
  void setErrorString(String errorString) {
    if (_errorString != errorString) {
      _errorString = errorString;
      notifyListeners();
    }
  }
}
