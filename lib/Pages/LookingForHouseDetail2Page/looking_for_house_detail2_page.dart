import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/CustomWidgets/index.dart';
import 'package:rental/Models/index.dart';
import 'package:rental/Pages/App/Styles/index.dart';
import 'package:rental/Services/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Constants/constants.dart';

class LookingForHouseDetail2Page extends StatelessWidget {
  LookingForHouseDetail2PageStyles _lookingForHouseDetail2PageStyles;
  LookingForHouseDetail2PageProvider _lookingForHouseDetail2PageProvider;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  HouseModel _houseModel = HouseModel();
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  @override
  Widget build(BuildContext context) {
    _lookingForHouseDetail2PageStyles = LookingForHouseDetail2PageStyles(context);
    _firebaseNotification.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LookingForHouseDetail2PageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _lookingForHouseDetail2PageStyles = LookingForHouseDetail2PageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _lookingForHouseDetail2PageStyles = LookingForHouseDetail2PageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _lookingForHouseDetail2PageStyles = LookingForHouseDetail2PageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _lookingForHouseDetail2PageStyles = LookingForHouseDetail2PageMobileStyles(context);
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
    print("___________ LookingForHouseDetail2Page ____________");
    _houseModel = ModalRoute.of(context).settings.arguments ?? HouseModel();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: _lookingForHouseDetail2PageStyles.deviceWidth,
            color: (_lookingForHouseDetail2PageStyles.runtimeType == LookingForHouseDetail2PageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _lookingForHouseDetail2PageStyles.mainWidth,
      // height: _lookingForHouseDetail2PageStyles.mainHeight,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _lookingForHouseDetail2PageStyles.primaryHorizontalPadding,
        vertical: _lookingForHouseDetail2PageStyles.primaryVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _containerHeader(context),
          _containerSearchItems(context),
          _containerNextStep(context),
        ],
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios, size: _lookingForHouseDetail2PageStyles.textFontSize, color: Colors.black),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    LookingForHouseDetail2PageString.headerText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: _lookingForHouseDetail2PageStyles.titleFontSize),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.arrow_forward_ios, size: _lookingForHouseDetail2PageStyles.textFontSize, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: _lookingForHouseDetail2PageStyles.fieldSpacing / 2),
          Center(
            child: Text(
              LookingForHouseDetail2PageString.hearderDescription,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _lookingForHouseDetail2PageStyles.textFontSize),
            ),
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
          /// --- property ---
          SizedBox(height: _lookingForHouseDetail2PageStyles.fieldSpacing),

          CustomDropDownFormField(
            menuItems: Constants.propertyItems,
            width: double.maxFinite,
            height: _lookingForHouseDetail2PageStyles.fieldItemHeight,
            label: LookingForHouseDetail2PageString.propertyLabel,
            labelSpacing: _lookingForHouseDetail2PageStyles.fieldSpacing / 3,
            itemTextFontSize: _lookingForHouseDetail2PageStyles.textFontSize,
            border: Border.all(color: Colors.grey),
            errorBorder: Border.all(color: Colors.red),
            borderRadius: _lookingForHouseDetail2PageStyles.widthDp * 10,
            hintText: LookingForHouseDetail2PageString.propertyHintText,
            iconSize: _lookingForHouseDetail2PageStyles.widthDp * 20,
            isExpanded: true,
            onChangeHandler: (value) {
              _houseModel.propertyType = value;
            },
            onValidateHandler: (value) {
              return (value == null) ? ValidateErrorString.dropdownItemErrorText : null;
            },
            onSaveHandler: (value) {
              _houseModel.propertyType = value;
            },
          ),

          /// --- size ---
          SizedBox(height: _lookingForHouseDetail2PageStyles.fieldSpacing),
          Text(
            LookingForHouseDetail2PageString.sizeLabel,
            style: TextStyle(fontSize: _lookingForHouseDetail2PageStyles.textFontSize),
          ),
          CustomSlideBar(
            width: double.infinity,
            height: _lookingForHouseDetail2PageStyles.slideBarHeight,
            min: Constants.sizeFrom.toDouble(),
            max: Constants.sizeTo.toDouble(),
            values: [Constants.sizeFrom.toDouble(), Constants.sizeTo.toDouble()],
            activeTrackBarHeight: _lookingForHouseDetail2PageStyles.widthDp * 15,
            inactiveTrackBarHeight: _lookingForHouseDetail2PageStyles.widthDp * 15,
            activeDisabledTrackBarColor: LookingForHouseDetail2PageColors.activeSliderColor,
            sliderBorderRadius: _lookingForHouseDetail2PageStyles.widthDp * 10,
            sliderBorderColor: Colors.grey[400],
            inactiveDisabledTrackBarColor: Colors.white,
            tooltipDisabled: true,
            tooltipTextStyle: TextStyle(fontSize: _lookingForHouseDetail2PageStyles.textFontSize * 0.8),
            tooltipBorderRadius: _lookingForHouseDetail2PageStyles.widthDp * 10,
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
              _houseModel.sizeFrom = double.parse(lowerValue.toString()).toInt();
              _houseModel.sizeTo = double.parse(upperValue.toString()).toInt();
            },
          ),

          /// --- renovatedLabel
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: CustomCheckBox(
                  width: double.maxFinite,
                  height: null,
                  label: LookingForHouseDetail2PageString.renovatedLabel,
                  labelFontSize: _lookingForHouseDetail2PageStyles.textFontSize,
                  iconColor: LookingForHouseDetail2PageColors.primaryColor,
                  onChanged: (value) {
                    _houseModel.isRenovated = value;
                  },
                ),
              ),
            ],
          ),

          /// --- yardLabel
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: CustomCheckBox(
                  width: double.maxFinite,
                  height: null,
                  label: LookingForHouseDetail2PageString.yardLabel,
                  labelFontSize: _lookingForHouseDetail2PageStyles.textFontSize,
                  iconColor: LookingForHouseDetail2PageColors.primaryColor,
                  onChanged: (value) {
                    _houseModel.haveYard = value;
                  },
                ),
              ),
            ],
          ),

          /// --- parkingLotLabel
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: CustomCheckBox(
                  width: double.maxFinite,
                  height: null,
                  label: LookingForHouseDetail2PageString.parkingLotLabel,
                  labelFontSize: _lookingForHouseDetail2PageStyles.textFontSize,
                  iconColor: LookingForHouseDetail2PageColors.primaryColor,
                  onChanged: (value) {
                    _houseModel.haveParkingLot = value;
                  },
                ),
              ),
            ],
          ),

          /// --- petsAllowedLabel
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: CustomCheckBox(
                  width: double.maxFinite,
                  height: null,
                  label: LookingForHouseDetail2PageString.petsAllowedLabel,
                  labelFontSize: _lookingForHouseDetail2PageStyles.textFontSize,
                  iconColor: LookingForHouseDetail2PageColors.primaryColor,
                  onChanged: (value) {
                    _houseModel.havePets = value;
                  },
                ),
              ),
            ],
          ),

          /// --- note
          SizedBox(height: _lookingForHouseDetail2PageStyles.fieldSpacing),
          CustomTextFormField(
            width: double.maxFinite,
            height: 200,
            label: LookingForHouseDetail2PageString.notesLabel,
            labelFontSize: _lookingForHouseDetail2PageStyles.textFontSize,
            labelSpacing: _lookingForHouseDetail2PageStyles.widthDp * 5,
            textFontSize: _lookingForHouseDetail2PageStyles.textFontSize,
            hintText: LookingForHouseDetail2PageString.notesHintText,
            hintTextColor: Colors.grey,
            hintTextFontSize: _lookingForHouseDetail2PageStyles.textFontSize,
            border: Border.all(width: 1, color: Colors.black),
            errorBorder: Border.all(width: 1, color: Colors.red),
            borderRadius: 4,
            keyboardType: TextInputType.multiline,
            maxLines: 100,
            onChangeHandler: (input) => _houseModel.notes = input.trim(),
            validatorHandler: (input) => (input.length < 10) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "10"}) : null,
            onSaveHandler: (input) => _houseModel.notes = input.trim(),
          ),
          SizedBox(height: _lookingForHouseDetail2PageStyles.fieldSpacing),
        ],
      ),
    );
  }

  Widget _containerNextStep(BuildContext context) {
    return CustomRaisedButton(
      width: double.infinity,
      height: _lookingForHouseDetail2PageStyles.nextStepHeight,
      color: LookingForHouseDetail2PageColors.primaryColor,
      borderColor: Colors.white,
      borderRadius: 10,
      child: Text(
        LookingForHouseDetail2PageString.finishButtonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _lookingForHouseDetail2PageStyles.nextStepTextFontSize, color: Colors.white),
      ),
      onPressed: () {
        finish(context);
      },
    );
  }

  void finish(BuildContext context) {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();
    print(_houseModel.toJson());
    Navigator.of(context).popUntil(ModalRoute.withName('/looking_for_page'));
    Navigator.of(context).pushNamed("/send_customer_info_page", arguments: {"houseModel": _houseModel});
  }
}
