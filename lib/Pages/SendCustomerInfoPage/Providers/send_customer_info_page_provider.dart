import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendCustomerInfoPageProvider extends ChangeNotifier {
  static SendCustomerInfoPageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<SendCustomerInfoPageProvider>(context, listen: listen);

  String _errorString = "";
  String get errorString => _errorString;
  void setErrorString(String errorString) {
    if (_errorString != errorString) {
      _errorString = errorString;
      notifyListeners();
    }
  }
}
