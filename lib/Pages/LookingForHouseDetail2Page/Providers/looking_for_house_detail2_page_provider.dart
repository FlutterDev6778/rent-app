import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LookingForHouseDetail2PageProvider extends ChangeNotifier {
  static LookingForHouseDetail2PageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<LookingForHouseDetail2PageProvider>(context, listen: listen);
}
