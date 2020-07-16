import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/CustomWidgets/custom_slider_bar.dart';
import 'package:rental/Models/index.dart';
import 'package:rental/Pages/App/index.dart';
import 'package:rental/Services/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/CustomWidgets/index.dart';

class LookingForCarDetail1Page extends StatelessWidget {
  LookingForCarDetail1PageStyles _lookingForCarDetail1PageStyles;
  LookingForCarDetail1PageProvider _lookingForCarDetail1PageProvider;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  CarModel _carModel = CarModel();
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  @override
  Widget build(BuildContext context) {
    _lookingForCarDetail1PageStyles = LookingForCarDetail1PageStyles(context);
    _firebaseNotification.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LookingForCarDetail1PageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _lookingForCarDetail1PageStyles = LookingForCarDetail1PageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _lookingForCarDetail1PageStyles = LookingForCarDetail1PageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _lookingForCarDetail1PageStyles = LookingForCarDetail1PageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _lookingForCarDetail1PageStyles = LookingForCarDetail1PageMobileStyles(context);
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
            width: _lookingForCarDetail1PageStyles.deviceWidth,
            color: (_lookingForCarDetail1PageStyles.runtimeType == LookingForCarDetail1PageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _lookingForCarDetail1PageStyles.mainWidth,
      height: _lookingForCarDetail1PageStyles.mainHeight,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _lookingForCarDetail1PageStyles.primaryHorizontalPadding,
        vertical: _lookingForCarDetail1PageStyles.primaryVerticalPadding,
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
            child: Icon(Icons.arrow_back_ios, size: _lookingForCarDetail1PageStyles.textFontSize, color: Colors.black),
          ),
          Expanded(
            child: Center(
              child: Text(
                LookingForCarDetail1PageString.headerText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: _lookingForCarDetail1PageStyles.titleFontSize),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.arrow_forward_ios, size: _lookingForCarDetail1PageStyles.textFontSize, color: Colors.white),
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
          /// --- producer ---
          SizedBox(height: _lookingForCarDetail1PageStyles.fieldSpacing),
          CustomDropDownFormField(
            menuItems: Constants.producerItems,
            value: (_carModel.producerList.length != 0) ? _carModel.producerList[0] : null,
            width: double.maxFinite,
            height: _lookingForCarDetail1PageStyles.fieldItemHeight,
            label: LookingForCarDetail1PageString.producerLabel,
            labelSpacing: _lookingForCarDetail1PageStyles.fieldSpacing / 3,
            itemTextFontSize: _lookingForCarDetail1PageStyles.textFontSize,
            border: Border.all(color: Colors.grey),
            errorBorder: Border.all(color: Colors.red),
            borderRadius: _lookingForCarDetail1PageStyles.widthDp * 10,
            isExpanded: true,
            hintText: LookingForCarDetail1PageString.producerHintText,
            onChangeHandler: (value) {
              _carModel.producerList = [value];
            },
            onValidateHandler: (value) {
              return (value == null) ? ValidateErrorString.dropdownItemErrorText : null;
            },
            onSaveHandler: (value) {
              _carModel.producerList = [value];
            },
          ),

          /// --- model ---
          SizedBox(height: _lookingForCarDetail1PageStyles.fieldSpacing),
          CustomDropDownFormField(
            menuItems: Constants.modelItems,
            value: (_carModel.modelList.length != 0) ? _carModel.modelList[0] : null,
            width: double.maxFinite,
            height: _lookingForCarDetail1PageStyles.fieldItemHeight,
            label: LookingForCarDetail1PageString.modelLabel,
            labelSpacing: _lookingForCarDetail1PageStyles.fieldSpacing / 3,
            itemTextFontSize: _lookingForCarDetail1PageStyles.textFontSize,
            border: Border.all(color: Colors.grey),
            errorBorder: Border.all(color: Colors.red),
            borderRadius: _lookingForCarDetail1PageStyles.widthDp * 10,
            hintText: LookingForCarDetail1PageString.modelHintText,
            isExpanded: true,
            onChangeHandler: (value) {
              _carModel.modelList = [value];
            },
            onValidateHandler: (value) {
              return (value == null) ? ValidateErrorString.dropdownItemErrorText : null;
            },
            onSaveHandler: (value) {
              _carModel.modelList = [value];
            },
          ),

          /// --- year ---
          SizedBox(height: _lookingForCarDetail1PageStyles.fieldSpacing),
          Text(
            LookingForCarDetail1PageString.yearLabel,
            style: TextStyle(fontSize: _lookingForCarDetail1PageStyles.textFontSize),
          ),
          CustomSlideBar(
            width: double.infinity,
            height: _lookingForCarDetail1PageStyles.slideBarHeight,
            values: [Constants.yearFrom.toDouble(), Constants.yearTo.toDouble()],
            min: Constants.yearFrom.toDouble(),
            max: Constants.yearTo.toDouble(),
            activeTrackBarHeight: _lookingForCarDetail1PageStyles.widthDp * 15,
            inactiveTrackBarHeight: _lookingForCarDetail1PageStyles.widthDp * 15,
            activeDisabledTrackBarColor: LookingForCarDetail1PageColors.activeSliderColor,
            sliderBorderRadius: _lookingForCarDetail1PageStyles.widthDp * 10,
            sliderBorderColor: Colors.grey[400],
            inactiveDisabledTrackBarColor: Colors.white,
            tooltipDisabled: true,
            tooltipTextStyle: TextStyle(fontSize: _lookingForCarDetail1PageStyles.textFontSize * 0.8),
            tooltipBorderRadius: _lookingForCarDetail1PageStyles.widthDp * 10,
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
              _carModel.yearFrom = double.parse(lowerValue.toString()).toInt();
              _carModel.yearTo = double.parse(upperValue.toString()).toInt();
            },
          ),

          /// --- price ---
          SizedBox(height: _lookingForCarDetail1PageStyles.fieldSpacing),
          Text(
            LookingForCarDetail1PageString.priceLabel,
            style: TextStyle(fontSize: _lookingForCarDetail1PageStyles.textFontSize),
          ),
          CustomSlideBar(
            width: double.infinity,
            height: _lookingForCarDetail1PageStyles.slideBarHeight,
            values: [Constants.priceFrom.toDouble(), Constants.priceTo.toDouble()],
            min: Constants.priceFrom.toDouble(),
            max: Constants.priceTo.toDouble(),
            activeTrackBarHeight: _lookingForCarDetail1PageStyles.widthDp * 15,
            inactiveTrackBarHeight: _lookingForCarDetail1PageStyles.widthDp * 15,
            activeDisabledTrackBarColor: LookingForCarDetail1PageColors.activeSliderColor,
            sliderBorderRadius: _lookingForCarDetail1PageStyles.widthDp * 10,
            sliderBorderColor: Colors.grey[400],
            inactiveDisabledTrackBarColor: Colors.white,
            tooltipDisabled: true,
            tooltipFormat: (value) => "₪" + value.toString(),
            tooltipTextStyle: TextStyle(fontSize: _lookingForCarDetail1PageStyles.textFontSize * 0.8),
            tooltipBorderRadius: _lookingForCarDetail1PageStyles.widthDp * 10,
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
              _carModel.priceFrom = double.parse(lowerValue.toString()).toInt();
              _carModel.priceTo = double.parse(upperValue.toString()).toInt();
            },
          ),
        ],
      ),
    );
  }

  Widget _containerNextStep(BuildContext context) {
    return CustomRaisedButton(
      width: double.infinity,
      height: _lookingForCarDetail1PageStyles.nextStepHeight,
      color: LookingForCarDetail1PageColors.primaryColor,
      borderColor: Colors.white,
      borderRadius: _lookingForCarDetail1PageStyles.widthDp * 10,
      child: Text(
        LookingForCarDetail1PageString.nextStepButtonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _lookingForCarDetail1PageStyles.nextStepTextFontSize, color: Colors.white),
      ),
      onPressed: () {
        nextStop(context);
      },
    );
  }

  void nextStop(BuildContext context) {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    Navigator.of(context).pushNamed("/looking_for_car_detail2_page", arguments: _carModel);
  }
}
