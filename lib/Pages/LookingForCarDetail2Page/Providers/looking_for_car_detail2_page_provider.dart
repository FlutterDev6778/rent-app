import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LookingForCarDetail2PageProvider extends ChangeNotifier {
  static LookingForCarDetail2PageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<LookingForCarDetail2PageProvider>(context, listen: listen);
}
