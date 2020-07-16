import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseOfferDetailPageProvider extends ChangeNotifier {
  static HouseOfferDetailPageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<HouseOfferDetailPageProvider>(context, listen: listen);
}
