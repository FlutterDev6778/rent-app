import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/Models/index.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/Pages/Components/car_item_widget.dart';
import 'package:rental/Pages/Components/house_item_widget.dart';

class OfferWithCustomerWidget extends StatelessWidget {
  OfferWithCustomerWidget({
    Key key,
    @required this.width,
    this.height,
    @required this.offerModel,
    @required this.customerModel,
    @required this.category,
    this.titleFontSize = 20,
    this.itemSpacing = 10,
    this.textFontSize = 15,
    this.horizontalPadding = 10,
    this.verticalPadding = 10,
    this.borderRadius = 10,
  }) : super(key: key);
  final double width;
  final double height;
  final OfferModel offerModel;
  final CustomerModel customerModel;
  final double titleFontSize;
  final double itemSpacing;
  final double textFontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final int category;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OfferWithCustomerWidgetProvider()),
      ],
      child: Consumer<OfferWithCustomerWidgetProvider>(
        builder: (context, customerItemWidgetProvider, _) {
          return Container(
            width: width,
            margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Color(0xFF3DB242),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: Colors.white,
                  ),
                  child: (category == 2)
                      ? HouseItemWidget(
                          width: width,
                          offerModel: offerModel,
                          titleFontSize: titleFontSize,
                          textFontSize: textFontSize,
                          itemSpacing: itemSpacing,
                          horizontalPadding: horizontalPadding / 2,
                          verticalPadding: verticalPadding / 2,
                        )
                      : CarItemWidget(
                          width: width,
                          offerModel: offerModel,
                          titleFontSize: titleFontSize,
                          textFontSize: textFontSize,
                          itemSpacing: itemSpacing,
                          horizontalPadding: horizontalPadding / 2,
                          verticalPadding: verticalPadding / 2,
                        ),
                ),
                SizedBox(height: verticalPadding / 2),
                Text("${customerModel.name}   ${customerModel.phoneNumber}",
                    style: TextStyle(
                      fontSize: textFontSize,
                      color: Colors.white,
                    )),
                SizedBox(height: verticalPadding / 2),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OfferWithCustomerWidgetProvider extends ChangeNotifier {
  static OfferWithCustomerWidgetProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<OfferWithCustomerWidgetProvider>(context, listen: listen);
}
