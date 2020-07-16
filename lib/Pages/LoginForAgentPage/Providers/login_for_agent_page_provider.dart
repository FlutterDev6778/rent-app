import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForAgentPageProvider extends ChangeNotifier {
  static LoginForAgentPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<LoginForAgentPageProvider>(context, listen: listen);

  int _selectCategory;
  int get selectCategory => _selectCategory;
  void setSelectCategory(int selectCategory) {
    if (_selectCategory != selectCategory) {
      _selectCategory = selectCategory;
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
