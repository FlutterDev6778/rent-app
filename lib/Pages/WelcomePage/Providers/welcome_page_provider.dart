import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePageProvider extends ChangeNotifier {
  static WelcomePageProvider of(BuildContext context, {bool listen = false}) => Provider.of<WelcomePageProvider>(context, listen: listen);
}
