import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LookingForHouseDetail1PageProvider extends ChangeNotifier {
  static LookingForHouseDetail1PageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<LookingForHouseDetail1PageProvider>(context, listen: listen);
}
