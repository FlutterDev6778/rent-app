import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarOfferDetailPageProvider extends ChangeNotifier {
  static CarOfferDetailPageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<CarOfferDetailPageProvider>(context, listen: listen);
}
