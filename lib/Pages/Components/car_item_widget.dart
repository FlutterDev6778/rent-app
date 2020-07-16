import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/Models/index.dart';
import 'package:easy_localization/easy_localization.dart' as EL;

class CarItemWidget extends StatelessWidget {
  CarItemWidget({
    Key key,
    @required this.width,
    this.height,
    @required this.offerModel,
    this.titleFontSize = 20,
    this.itemSpacing = 10,
    this.textFontSize = 15,
    this.horizontalPadding = 10,
    this.verticalPadding = 10,
  }) : super(key: key);
  final double width;
  final double height;
  final OfferModel offerModel;
  final double titleFontSize;
  final double itemSpacing;
  final double textFontSize;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    String producerText = "";
    offerModel.carModel.producerList.forEach((producer) {
      for (var i = 0; i < Constants.producerItems.length; i++) {
        if (Constants.producerItems[i]["value"] == producer) {
          producerText += ", ${Constants.producerItems[i]["text"]}";
          break;
        }
      }
    });
    producerText = producerText.substring(1);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarItemWidgetProvider()),
      ],
      child: Consumer<CarItemWidgetProvider>(
        builder: (context, customCheckBoxProvider, _) {
          return Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  producerText,
                  style: TextStyle(fontSize: titleFontSize),
                ),
                SizedBox(height: itemSpacing * 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.location_on, size: textFontSize, color: Colors.black),
                    SizedBox(width: 5),
                    Text(
                      "CarItemWidget.kilometerText".tr(namedArgs: {"kilometer": offerModel.carModel.kilometer.toString()}),
                      style: TextStyle(fontSize: textFontSize),
                    ),
                  ],
                ),
                SizedBox(height: itemSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.date_range, size: textFontSize, color: Colors.black),
                    SizedBox(width: 5),
                    Text(
                      "CarItemWidget.yearText".tr(namedArgs: {
                        "yearFrom": offerModel.carModel.yearFrom.toString(),
                        "yearTo": offerModel.carModel.yearTo.toString(),
                      }),
                      style: TextStyle(fontSize: textFontSize),
                    ),
                  ],
                ),
                SizedBox(height: itemSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("CarItemWidget.revealText".tr(args: [offerModel.agentList.length.toString()]),
                        style: TextStyle(fontSize: textFontSize, color: Color(0xFF3DB242))),
                    Text(
                      "CarItemWidget.priceText".tr(namedArgs: {
                        "priceFrom": offerModel.carModel.priceFrom.toString(),
                        "priceTo": offerModel.carModel.priceTo.toString(),
                      }),
                      style: TextStyle(fontSize: textFontSize, color: Color(0xFFE28037)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CarItemWidgetProvider extends ChangeNotifier {
  static CarItemWidgetProvider of(BuildContext context, {bool listen = false}) => Provider.of<CarItemWidgetProvider>(context, listen: listen);
}
