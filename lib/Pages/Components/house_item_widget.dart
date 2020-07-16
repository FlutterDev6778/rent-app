import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/Models/index.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/Utils/index.dart';

class HouseItemWidget extends StatelessWidget {
  HouseItemWidget({
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HouseItemWidgetProvider()),
      ],
      child: Consumer<HouseItemWidgetProvider>(
        builder: (context, customCheckBoxProvider, _) {
          String city;
          for (var i = 0; i < Constants.cityItems.length; i++) {
            if (Constants.cityItems[i]["value"] == offerModel.houseModel.city) {
              city = Constants.cityItems[i]["text"];
              break;
            }
          }
          return Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "HouseItemWidget.title".tr(
                    namedArgs: {"roomsFrom": offerModel.houseModel.roomsFrom.toString(), "roomsTo": offerModel.houseModel.roomsTo.toString()},
                  ),
                  style: TextStyle(fontSize: titleFontSize),
                ),
                SizedBox(height: itemSpacing * 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.location_on, size: textFontSize, color: Colors.black),
                    SizedBox(width: 5),
                    Text(city, style: TextStyle(fontSize: textFontSize)),
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
                      convertMillisecondsToDateString(offerModel.houseModel.ts, formats: [yyyy, '-', mm, '-', dd]),
                      style: TextStyle(fontSize: textFontSize),
                    ),
                  ],
                ),
                SizedBox(height: itemSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("HouseItemWidget.revealText".tr(args: [offerModel.agentList.length.toString()]),
                        style: TextStyle(fontSize: textFontSize, color: Color(0xFF3DB242))),
                    Text(
                      "HouseItemWidget.priceText".tr(namedArgs: {
                        "priceFrom": offerModel.houseModel.priceFrom.toString(),
                        "priceTo": offerModel.houseModel.priceTo.toString(),
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

class HouseItemWidgetProvider extends ChangeNotifier {
  static HouseItemWidgetProvider of(BuildContext context, {bool listen = false}) => Provider.of<HouseItemWidgetProvider>(context, listen: listen);
}
