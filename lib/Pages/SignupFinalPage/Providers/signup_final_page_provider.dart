import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupFinalPageProvider extends ChangeNotifier {
  static SignupFinalPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<SignupFinalPageProvider>(context, listen: listen);
}
