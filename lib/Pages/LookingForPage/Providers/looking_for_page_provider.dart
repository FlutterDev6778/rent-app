import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LookingForPageProvider extends ChangeNotifier {
  static LookingForPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<LookingForPageProvider>(context, listen: listen);

  int _selectCategory;
  int get selectCategory => _selectCategory;
  void setSelectCategory(int selectCategory) {
    if (_selectCategory != selectCategory) {
      _selectCategory = selectCategory;
      notifyListeners();
    }
  }
}
