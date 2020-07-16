import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/CustomWidgets/index.dart';
import 'package:rental/DataProviders/index.dart';
import 'package:rental/Services/index.dart';
import 'package:rental/Utils/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/CustomWidgets/custom_raised_button.dart';
import 'package:rental/CustomWidgets/custom_checkbox.dart';
import 'package:rental/CustomWidgets/custom_text_form_field.dart';
import 'package:rental/Models/index.dart';
import 'package:rental/Pages/LoginForAgentPage/login_for_agent_page.dart';
import 'package:rental/Pages/SignupFinalPage/signup_final_page.dart';
import 'package:rental/Models/house_model.dart';

class HouseOfferDetailPage extends StatelessWidget {
  HouseOfferDetailPage({
    @required this.offerModel,
    @required this.isConnected,
    @required this.customerModel,
    @required this.agentModel,
  });

  HouseOfferDetailPageStyles _houseOfferDetailPageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  OfferDataProvider _offerDataProvider = OfferDataProvider();

  OfferModel offerModel;
  CustomerModel customerModel;
  bool isConnected;
  AgentModel agentModel;

  @override
  Widget build(BuildContext context) {
    _houseOfferDetailPageStyles = HouseOfferDetailPageStyles(context);
    _firebaseNotification.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HouseOfferDetailPageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _houseOfferDetailPageStyles = HouseOfferDetailPageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _houseOfferDetailPageStyles = HouseOfferDetailPageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _houseOfferDetailPageStyles = HouseOfferDetailPageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _houseOfferDetailPageStyles = HouseOfferDetailPageMobileStyles(context);
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              width: _houseOfferDetailPageStyles.deviceWidth,
              color: (_houseOfferDetailPageStyles.runtimeType == HouseOfferDetailPageMobileStyles) ? Colors.white : Colors.grey[200],
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
      width: _houseOfferDetailPageStyles.mainWidth,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _houseOfferDetailPageStyles.primaryHorizontalPadding,
        vertical: _houseOfferDetailPageStyles.primaryVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _containerHeader(context),
          SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
          _containerItems(context),
          SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
          SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
          _containerRevealLink(context),
          SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing / 2),
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
            child: Icon(Icons.arrow_back_ios, size: _houseOfferDetailPageStyles.textFontSize, color: Colors.black),
          ),
          Expanded(
            child: Center(
              child: Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: _houseOfferDetailPageStyles.titleFontSize, color: Colors.white),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.arrow_forward_ios, size: _houseOfferDetailPageStyles.textFontSize, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _containerItems(BuildContext context) {
    String city;
    for (var i = 0; i < Constants.cityItems.length; i++) {
      if (Constants.cityItems[i]["value"] == offerModel.houseModel.city) {
        city = Constants.cityItems[i]["text"];
        break;
      }
    }

    String property;
    for (var i = 0; i < Constants.propertyItems.length; i++) {
      if (Constants.propertyItems[i]["value"] == offerModel.houseModel.propertyType) {
        property = Constants.propertyItems[i]["text"];
        break;
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Text(
          HouseOfferDetailPageString.title.tr(
            namedArgs: {"roomsFrom": offerModel.houseModel.roomsFrom.toString(), "roomsTo": offerModel.houseModel.roomsTo.toString()},
          ),
          style: TextStyle(fontSize: _houseOfferDetailPageStyles.titleFontSize),
        ),
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),

        /// --- city
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: _houseOfferDetailPageStyles.textFontSize,
              color: HouseOfferDetailPageColors.primaryColor,
            ),
            SizedBox(width: 5),
            Text(city, style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize)),
          ],
        ),

        /// --- date
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.date_range,
              size: _houseOfferDetailPageStyles.textFontSize,
              color: HouseOfferDetailPageColors.primaryColor,
            ),
            SizedBox(width: 5),
            Text(
              convertMillisecondsToDateString(offerModel.houseModel.ts, formats: [yyyy, '-', mm, '-', dd]),
              style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize),
            ),
          ],
        ),

        /// --- price
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(HouseOfferDetailPageString.priceLabel, style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize)),
            SizedBox(width: 25),
            Text(
              HouseOfferDetailPageString.priceText.tr(namedArgs: {
                "priceFrom": offerModel.houseModel.priceFrom.toString(),
                "priceTo": offerModel.houseModel.priceTo.toString(),
              }),
              style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize),
            ),
          ],
        ),

        /// --- Rooms
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(HouseOfferDetailPageString.roomsLabel, style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize)),
            SizedBox(width: 25),
            Text(
              HouseOfferDetailPageString.roomsText.tr(namedArgs: {
                "roomsFrom": offerModel.houseModel.roomsFrom.toString(),
                "roomsTo": offerModel.houseModel.roomsTo.toString(),
              }),
              style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize),
            ),
          ],
        ),

        /// --- Rooms
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(HouseOfferDetailPageString.propertyLabel, style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize)),
            SizedBox(width: 25),
            Text(
              property,
              style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize),
            ),
          ],
        ),

        /// --- size
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(HouseOfferDetailPageString.sizeLabel, style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize)),
            SizedBox(width: 25),
            Text(
              HouseOfferDetailPageString.sizeText.tr(namedArgs: {
                "sizeFrom": offerModel.houseModel.sizeFrom.toString(),
                "sizeTo": offerModel.houseModel.sizeTo.toString(),
              }),
              style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize),
            ),
          ],
        ),

        /// --- ch
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: (_houseOfferDetailPageStyles.mainWidth - _houseOfferDetailPageStyles.primaryHorizontalPadding * 2) / 2,
              child: CustomCheckBox(
                width: double.maxFinite,
                height: null,
                label: HouseOfferDetailPageString.renovatedLabel,
                labelFontSize: _houseOfferDetailPageStyles.textFontSize,
                iconColor: HouseOfferDetailPageColors.primaryColor,
                readOnly: true,
                value: offerModel.houseModel.isRenovated,
              ),
            ),
            Container(
              width: (_houseOfferDetailPageStyles.mainWidth - _houseOfferDetailPageStyles.primaryHorizontalPadding * 2) / 2,
              child: CustomCheckBox(
                width: double.maxFinite,
                height: null,
                label: HouseOfferDetailPageString.parkingLotLabel,
                labelFontSize: _houseOfferDetailPageStyles.textFontSize,
                iconColor: HouseOfferDetailPageColors.primaryColor,
                readOnly: true,
                value: offerModel.houseModel.haveParkingLot,
              ),
            ),
          ],
        ),

        /// --- ch
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: (_houseOfferDetailPageStyles.mainWidth - _houseOfferDetailPageStyles.primaryHorizontalPadding * 2) / 2,
              child: CustomCheckBox(
                width: double.maxFinite,
                height: null,
                label: HouseOfferDetailPageString.yardLabel,
                labelFontSize: _houseOfferDetailPageStyles.textFontSize,
                iconColor: HouseOfferDetailPageColors.primaryColor,
                readOnly: true,
                value: offerModel.houseModel.haveYard,
              ),
            ),
            Container(
              width: (_houseOfferDetailPageStyles.mainWidth - _houseOfferDetailPageStyles.primaryHorizontalPadding * 2) / 2,
              child: CustomCheckBox(
                width: double.maxFinite,
                height: null,
                label: HouseOfferDetailPageString.petsLabel,
                labelFontSize: _houseOfferDetailPageStyles.textFontSize,
                iconColor: HouseOfferDetailPageColors.primaryColor,
                readOnly: true,
                value: offerModel.houseModel.havePets,
              ),
            ),
          ],
        ),

        /// --- notes
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing),
        Text(
          HouseOfferDetailPageString.notesLabel,
          style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize, color: HouseOfferDetailPageColors.secondaryColor),
        ),
        SizedBox(height: _houseOfferDetailPageStyles.fieldSpacing / 2),
        Text(
          offerModel.houseModel.notes,
          style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _containerRevealButton(BuildContext context) {
    return CustomRaisedButton(
      width: double.infinity,
      height: _houseOfferDetailPageStyles.revealButtonHeight,
      color: HouseOfferDetailPageColors.primaryColor,
      borderColor: Colors.white,
      borderRadius: 10,
      child: Text(
        (isConnected) ? "${customerModel.name}  ${customerModel.phoneNumber}" : HouseOfferDetailPageString.revealButtonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _houseOfferDetailPageStyles.revealButtonTextFontSize, color: Colors.white),
      ),
      onPressed: () {
        if (!isConnected) reval(context);
      },
    );
  }

  Widget _containerRevealLink(BuildContext context) {
    return Text(
      (isConnected)
          ? HouseOfferDetailPageString.revealTextForConnectedOffer.tr(args: [offerModel.agentList.length.toString()])
          : HouseOfferDetailPageString.revealText.tr(args: [offerModel.agentList.length.toString()]),
      style: TextStyle(fontSize: _houseOfferDetailPageStyles.textFontSize, color: HouseOfferDetailPageColors.secondaryColor),
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
