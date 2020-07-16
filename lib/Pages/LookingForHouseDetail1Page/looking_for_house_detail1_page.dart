import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/CustomWidgets/custom_slider_bar.dart';
import 'package:rental/CustomWidgets/index.dart';
import 'package:rental/Models/index.dart';
import 'package:rental/Pages/App/Styles/index.dart';
import 'package:rental/Services/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/CustomWidgets/custom_raised_button.dart';
import 'package:rental/CustomWidgets/custom_drop_down.dart';

class LookingForHouseDetail1Page extends StatelessWidget {
  LookingForHouseDetail1PageStyles _lookingForHouseDetail1PageStyles;
  LookingForHouseDetail1PageProvider _lookingForHouseDetail1PageProvider;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  HouseModel _houseModel = HouseModel();
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  @override
  Widget build(BuildContext context) {
    _lookingForHouseDetail1PageStyles = LookingForHouseDetail1PageStyles(context);
    _firebaseNotification.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LookingForHouseDetail1PageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _lookingForHouseDetail1PageStyles = LookingForHouseDetail1PageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _lookingForHouseDetail1PageStyles = LookingForHouseDetail1PageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _lookingForHouseDetail1PageStyles = LookingForHouseDetail1PageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _lookingForHouseDetail1PageStyles = LookingForHouseDetail1PageMobileStyles(context);
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
        body: SingleChildScrollView(
          child: Container(
            width: _lookingForHouseDetail1PageStyles.deviceWidth,
            color: (_lookingForHouseDetail1PageStyles.runtimeType == LookingForHouseDetail1PageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _lookingForHouseDetail1PageStyles.mainWidth,
      height: _lookingForHouseDetail1PageStyles.mainHeight,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _lookingForHouseDetail1PageStyles.primaryHorizontalPadding,
        vertical: _lookingForHouseDetail1PageStyles.primaryVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _containerHeader(context),
          Expanded(child: _containerSearchItems(context)),
          _containerNextStep(context),
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
            child: Icon(Icons.arrow_back_ios, size: _lookingForHouseDetail1PageStyles.textFontSize, color: Colors.black),
          ),
          Expanded(
            child: Center(
              child: Text(
                LookingForHouseDetail1PageString.headerText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: _lookingForHouseDetail1PageStyles.titleFontSize),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.arrow_forward_ios, size: _lookingForHouseDetail1PageStyles.textFontSize, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _containerSearchItems(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// --- city ---
          SizedBox(height: _lookingForHouseDetail1PageStyles.fieldSpacing),
          CustomDropDownFormField(
            menuItems: Constants.cityItems,
            width: double.maxFinite,
            label: LookingForHouseDetail1PageString.cityLabel,
            labelSpacing: _lookingForHouseDetail1PageStyles.fieldSpacing / 3,
            itemTextFontSize: _lookingForHouseDetail1PageStyles.textFontSize,
            height: _lookingForHouseDetail1PageStyles.fieldItemHeight,
            border: Border.all(color: Colors.grey),
            errorBorder: Border.all(color: Colors.red),
            borderRadius: _lookingForHouseDetail1PageStyles.widthDp * 10,
            hintText: LookingForHouseDetail1PageString.cityHintText,
            isExpanded: true,
            onChangeHandler: (value) {
              _houseModel.city = value;
            },
            onValidateHandler: (value) {
              return (value == null) ? ValidateErrorString.dropdownItemErrorText : null;
            },
            onSaveHandler: (value) {
              _houseModel.city = value;
            },
          ),

          /// --- price ---
          SizedBox(height: _lookingForHouseDetail1PageStyles.fieldSpacing),
          Text(
            LookingForHouseDetail1PageString.priceLabel,
            style: TextStyle(fontSize: _lookingForHouseDetail1PageStyles.textFontSize),
          ),
          CustomSlideBar(
            width: double.infinity,
            height: _lookingForHouseDetail1PageStyles.slideBarHeight,
            values: [Constants.priceFrom.toDouble(), Constants.priceTo.toDouble()],
            min: Constants.priceFrom.toDouble(),
            max: Constants.priceTo.toDouble(),
            activeTrackBarHeight: _lookingForHouseDetail1PageStyles.widthDp * 15,
            inactiveTrackBarHeight: _lookingForHouseDetail1PageStyles.widthDp * 15,
            activeDisabledTrackBarColor: LookingForHouseDetail1PageColors.activeSliderColor,
            sliderBorderRadius: _lookingForHouseDetail1PageStyles.widthDp * 10,
            sliderBorderColor: Colors.grey[400],
            inactiveDisabledTrackBarColor: Colors.white,
            tooltipDisabled: true,
            tooltipFormat: (value) => "₪" + value.toString(),
            tooltipTextStyle: TextStyle(fontSize: _lookingForHouseDetail1PageStyles.textFontSize * 0.8),
            tooltipBorderRadius: _lookingForHouseDetail1PageStyles.widthDp * 10,
            tooltipColor: Colors.white,
            rtl: (EL.EasyLocalization.of(context).locale.languageCode.toString() == "ar") ? true : false,
            tooltipBoxShadow: BoxShadow(
              color: Colors.grey[400],
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(0, 2),
            ),
            enableCenterTooltip: true,
            onDragCompleted: (handlerIndex, lowerValue, upperValue) {
              _houseModel.priceFrom = double.parse(lowerValue.toString()).toInt();
              _houseModel.priceTo = double.parse(upperValue.toString()).toInt();
            },
          ),

          /// --- rooms ---
          SizedBox(height: _lookingForHouseDetail1PageStyles.fieldSpacing),
          Text(
            LookingForHouseDetail1PageString.roomsLabel,
            style: TextStyle(fontSize: _lookingForHouseDetail1PageStyles.textFontSize),
          ),
          CustomSlideBar(
            width: double.infinity,
            height: _lookingForHouseDetail1PageStyles.slideBarHeight,
            values: [Constants.roomsFrom.toDouble(), Constants.roomsTo.toDouble()],
            min: Constants.roomsFrom.toDouble(),
            max: Constants.roomsTo.toDouble(),
            activeTrackBarHeight: _lookingForHouseDetail1PageStyles.widthDp * 15,
            inactiveTrackBarHeight: _lookingForHouseDetail1PageStyles.widthDp * 15,
            activeDisabledTrackBarColor: LookingForHouseDetail1PageColors.activeSliderColor,
            sliderBorderRadius: _lookingForHouseDetail1PageStyles.widthDp * 10,
            sliderBorderColor: Colors.grey[400],
            inactiveDisabledTrackBarColor: Colors.white,
            tooltipDisabled: true,
            tooltipFormat: (value) => "₪" + value.toString(),
            tooltipTextStyle: TextStyle(fontSize: _lookingForHouseDetail1PageStyles.textFontSize * 0.8),
            tooltipBorderRadius: _lookingForHouseDetail1PageStyles.widthDp * 10,
            tooltipColor: Colors.white,
            rtl: (EL.EasyLocalization.of(context).locale.languageCode.toString() == "ar") ? true : false,
            tooltipBoxShadow: BoxShadow(
              color: Colors.grey[400],
              blurRadius: 2,
              spreadRadius: 0,
              offset: Offset(0, 2),
            ),
            enableCenterTooltip: true,
            onDragCompleted: (handlerIndex, lowerValue, upperValue) {
              _houseModel.roomsFrom = double.parse(lowerValue.toString()).toInt();
              _houseModel.roomsTo = double.parse(upperValue.toString()).toInt();
            },
          ),
        ],
      ),
    );
  }

  Widget _containerNextStep(BuildContext context) {
    return CustomRaisedButton(
      width: double.infinity,
      height: _lookingForHouseDetail1PageStyles.nextStepHeight,
      color: LookingForHouseDetail1PageColors.primaryColor,
      borderColor: Colors.white,
      borderRadius: 10,
      child: Text(
        LookingForHouseDetail1PageString.nextStepButtonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _lookingForHouseDetail1PageStyles.nextStepTextFontSize, color: Colors.white),
      ),
      onPressed: () {
        nextStop(context);
      },
    );
  }

  void nextStop(BuildContext context) {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    Navigator.of(context).pushNamed("/looking_for_house_detail2_page", arguments: _houseModel);
  }
}
