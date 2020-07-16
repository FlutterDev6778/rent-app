import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LookingForCarDetail1PageProvider extends ChangeNotifier {
  static LookingForCarDetail1PageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<LookingForCarDetail1PageProvider>(context, listen: listen);

  int _selectCategory;
  int get selectCategory => _selectCategory;
  void setSelectCategory(int selectCategory) {
    if (_selectCategory != selectCategory) {
      _selectCategory = selectCategory;
      notifyListeners();
    }
  }
}
