import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/DataProviders/offer_data_provider.dart';
import 'package:rental/Models/car_model.dart';
import 'package:rental/Services/index.dart';
import 'package:rental/Utils/date_time_convert.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/CustomWidgets/index.dart';
import 'package:rental/Models/index.dart';

class CarOfferDetailPage extends StatelessWidget {
  CarOfferDetailPage({
    @required this.offerModel,
    @required this.isConnected,
    @required this.customerModel,
    @required this.agentModel,
  });

  CarOfferDetailPageStyles _carOfferDetailPageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  OfferDataProvider _offerDataProvider = OfferDataProvider();

  OfferModel offerModel;
  CustomerModel customerModel;
  bool isConnected;
  AgentModel agentModel;

  @override
  Widget build(BuildContext context) {
    _carOfferDetailPageStyles = CarOfferDetailPageStyles(context);
    _firebaseNotification.init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarOfferDetailPageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _carOfferDetailPageStyles = CarOfferDetailPageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _carOfferDetailPageStyles = CarOfferDetailPageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _carOfferDetailPageStyles = CarOfferDetailPageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _carOfferDetailPageStyles = CarOfferDetailPageMobileStyles(context);
          }

          if (kIsWeb)
            return LayoutBuilder(
              builder: (context, constraints) {
                return _containerMain(context);
              },
            );
          else
            return _containerMain(context);
        },
      ),
    );
  }

  Widget _containerMain(BuildContext context) {
    print("__________ CarOfferDetailPage _____________");
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              width: _carOfferDetailPageStyles.deviceWidth,
              color: (_carOfferDetailPageStyles.runtimeType == CarOfferDetailPageMobileStyles) ? Colors.white : Colors.grey[200],
              alignment: Alignment.topCenter,
              child: _containerBody(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _carOfferDetailPageStyles.mainWidth,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _carOfferDetailPageStyles.primaryHorizontalPadding,
        vertical: _carOfferDetailPageStyles.primaryVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _containerHeader(context),
          SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
          _containerItems(context),
          SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
          SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
          _containerRevealLink(context),
          SizedBox(height: _carOfferDetailPageStyles.fieldSpacing / 2),
          _containerRevealButton(context),
        ],
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios, size: _carOfferDetailPageStyles.textFontSize, color: Colors.black),
          ),
          Expanded(
            child: Center(
              child: Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: _carOfferDetailPageStyles.titleFontSize, color: Colors.white),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.arrow_forward_ios, size: _carOfferDetailPageStyles.textFontSize, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _containerItems(BuildContext context) {
    String producerText = "";
    String modelText = "";

    offerModel.carModel.producerList.forEach((producer) {
      for (var i = 0; i < Constants.producerItems.length; i++) {
        if (Constants.producerItems[i]["value"] == producer) {
          producerText += ", ${Constants.producerItems[i]['text']}";
          break;
        }
      }
    });
    producerText = producerText.substring(1);

    offerModel.carModel.modelList.forEach((model) {
      for (var i = 0; i < Constants.modelItems.length; i++) {
        if (Constants.modelItems[i]["value"] == model) {
          modelText += ", ${Constants.modelItems[i]['text']}";
          break;
        }
      }
    });
    modelText = modelText.substring(1);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
        Text(
          producerText,
          style: TextStyle(fontSize: _carOfferDetailPageStyles.titleFontSize),
        ),
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing * 1.5),

        Text(
          modelText,
          style: TextStyle(fontSize: _carOfferDetailPageStyles.titleFontSize),
        ),
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),

        /// --- kilometer
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: _carOfferDetailPageStyles.textFontSize,
              color: CarOfferDetailPageColors.primaryColor,
            ),
            SizedBox(width: 5),
            Text(CarOfferDetailPageString.kilometerText.tr(namedArgs: {"kilometer": offerModel.carModel.kilometer.toInt().toString()}),
                style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize)),
          ],
        ),

        /// --- date
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.date_range,
              size: _carOfferDetailPageStyles.textFontSize,
              color: CarOfferDetailPageColors.primaryColor,
            ),
            SizedBox(width: 5),
            Text(
              convertMillisecondsToDateString(offerModel.carModel.ts, formats: [yyyy, '-', mm, '-', dd]),
              style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize),
            ),
          ],
        ),

        /// --- price
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(CarOfferDetailPageString.priceLabel, style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize)),
            SizedBox(width: 25),
            Text(
              CarOfferDetailPageString.priceText.tr(namedArgs: {
                "priceFrom": offerModel.carModel.priceFrom.toString(),
                "priceTo": offerModel.carModel.priceTo.toString(),
              }),
              style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize),
            ),
          ],
        ),

        /// --- hand
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(CarOfferDetailPageString.handLabel, style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize)),
            SizedBox(width: 25),
            Text(
              CarOfferDetailPageString.handText.tr(namedArgs: {
                "handFrom": offerModel.carModel.handFrom.toString(),
                "handTo": offerModel.carModel.handTo.toString(),
              }),
              style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize),
            ),
          ],
        ),

        /// --- Color
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(CarOfferDetailPageString.colorLabel, style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize)),
            SizedBox(width: 25),
            Text(
              offerModel.carModel.color,
              style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize),
            ),
          ],
        ),

        /// --- ch
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: (_carOfferDetailPageStyles.mainWidth - _carOfferDetailPageStyles.primaryHorizontalPadding * 2) / 2,
              child: CustomCheckBox(
                width: double.maxFinite,
                height: null,
                label: CarOfferDetailPageString.gearLabel,
                labelFontSize: _carOfferDetailPageStyles.textFontSize,
                iconColor: CarOfferDetailPageColors.primaryColor,
                readOnly: true,
                value: offerModel.carModel.haveGear,
              ),
            ),
            Container(
              width: (_carOfferDetailPageStyles.mainWidth - _carOfferDetailPageStyles.primaryHorizontalPadding * 2) / 2,
              child: CustomCheckBox(
                width: double.maxFinite,
                height: null,
                label: CarOfferDetailPageString.autoLotLabel,
                labelFontSize: _carOfferDetailPageStyles.textFontSize,
                iconColor: CarOfferDetailPageColors.primaryColor,
                readOnly: true,
                value: offerModel.carModel.haveAuto,
              ),
            ),
          ],
        ),

        /// --- notes
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing),
        Text(
          CarOfferDetailPageString.notesLabel,
          style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize, color: CarOfferDetailPageColors.secondaryColor),
        ),
        SizedBox(height: _carOfferDetailPageStyles.fieldSpacing / 2),
        Text(
          offerModel.carModel.notes,
          style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _containerRevealButton(BuildContext context) {
    return CustomRaisedButton(
      width: double.infinity,
      height: _carOfferDetailPageStyles.revealButtonHeight,
      color: CarOfferDetailPageColors.primaryColor,
      borderColor: Colors.white,
      borderRadius: 10,
      child: Text(
        (isConnected) ? "${customerModel.name}  ${customerModel.phoneNumber}" : CarOfferDetailPageString.revealButtonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _carOfferDetailPageStyles.revealButtonTextFontSize, color: Colors.white),
      ),
      onPressed: () {
        if (!isConnected) reval(context);
      },
    );
  }

  Widget _containerRevealLink(BuildContext context) {
    return Text(
      (isConnected)
          ? CarOfferDetailPageString.revealTextForConnectedOffer.tr(args: [offerModel.agentList.length.toString()])
          : CarOfferDetailPageString.revealText.tr(args: [offerModel.agentList.length.toString()]),
      style: TextStyle(fontSize: _carOfferDetailPageStyles.textFontSize, color: CarOfferDetailPageColors.secondaryColor),
    );
  }

  void reval(BuildContext context) async {
    await CustomProgressDialog.of(context: context).show();
    OfferModel _newOfferModel = offerModel;
    _newOfferModel.agentList.add(agentModel.id);
    var result = await _offerDataProvider.updateOffer(offerModel: _newOfferModel);
    await CustomProgressDialog.of(context: context).hide();
    if (result) {
      Navigator.of(context).pop();
    }
  }
}
