import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/CustomWidgets/custom_checkbox.dart';
import 'package:rental/CustomWidgets/custom_slider_bar.dart';
import 'package:rental/CustomWidgets/custom_text_form_field.dart';
import 'package:rental/CustomWidgets/index.dart';
import 'package:rental/Models/index.dart';
import 'package:rental/Pages/App/Styles/index.dart';
import 'package:rental/Services/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/CustomWidgets/custom_raised_button.dart';
import 'package:rental/CustomWidgets/custom_drop_down.dart';

class LookingForCarDetail2Page extends StatelessWidget {
  LookingForCarDetail2PageStyles _lookingForCarDetail2PageStyles;
  LookingForCarDetail2PageProvider _lookingForCarDetail2PageProvider;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  CarModel _carModel = CarModel();
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  @override
  Widget build(BuildContext context) {
    _lookingForCarDetail2PageStyles = LookingForCarDetail2PageStyles(context);
    _firebaseNotification.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LookingForCarDetail2PageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _lookingForCarDetail2PageStyles = LookingForCarDetail2PageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _lookingForCarDetail2PageStyles = LookingForCarDetail2PageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _lookingForCarDetail2PageStyles = LookingForCarDetail2PageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _lookingForCarDetail2PageStyles = LookingForCarDetail2PageMobileStyles(context);
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
    print("___________ LookingForCarDetail2Page ____________");
    _carModel = ModalRoute.of(context).settings.arguments ?? CarModel();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: _lookingForCarDetail2PageStyles.deviceWidth,
            color: (_lookingForCarDetail2PageStyles.runtimeType == LookingForCarDetail2PageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _lookingForCarDetail2PageStyles.mainWidth,
      // height: _lookingForCarDetail2PageStyles.mainHeight,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _lookingForCarDetail2PageStyles.primaryHorizontalPadding,
        vertical: _lookingForCarDetail2PageStyles.primaryVerticalPadding,
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
                child: Icon(Icons.arrow_back_ios, size: _lookingForCarDetail2PageStyles.textFontSize, color: Colors.black),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    LookingForCarDetail2PageString.headerText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: _lookingForCarDetail2PageStyles.titleFontSize),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.arrow_forward_ios, size: _lookingForCarDetail2PageStyles.textFontSize, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: _lookingForCarDetail2PageStyles.fieldSpacing),
          Center(
            child: Text(
              LookingForCarDetail2PageString.hearderDescription,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _lookingForCarDetail2PageStyles.textFontSize),
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
          /// --- color ---
          SizedBox(height: _lookingForCarDetail2PageStyles.fieldSpacing),

          CustomDropDownFormField(
            menuItems: Constants.colorItems,
            width: double.maxFinite,
            height: _lookingForCarDetail2PageStyles.fieldItemHeight,
            label: "LookingForCarDetail2Page.colorLabel".tr(),
            labelSpacing: _lookingForCarDetail2PageStyles.fieldSpacing / 3,
            itemTextFontSize: _lookingForCarDetail2PageStyles.textFontSize,
            border: Border.all(color: Colors.grey),
            errorBorder: Border.all(color: Colors.red),
            borderRadius: _lookingForCarDetail2PageStyles.widthDp * 10,
            hintText: "LookingForCarDetail2Page.colorHintText".tr(),
            isExpanded: true,
            onChangeHandler: (value) {
              _carModel.color = value;
            },
            onValidateHandler: (value) {
              return (value == null) ? ValidateErrorString.dropdownItemErrorText : null;
            },
            onSaveHandler: (value) {
              _carModel.color = value;
            },
          ),

          /// --- Kilometer ---
          SizedBox(height: _lookingForCarDetail2PageStyles.fieldSpacing),
          Text(
            "LookingForCarDetail2Page.kilometerLabel".tr(),
            style: TextStyle(fontSize: _lookingForCarDetail2PageStyles.textFontSize),
          ),
          CustomSlideBar(
            width: double.infinity,
            height: _lookingForCarDetail2PageStyles.slideBarHeight,
            min: Constants.kilometerFrom.toDouble(),
            max: Constants.kilometerTo.toDouble(),
            values: [Constants.kilometerTo / 2],
            activeTrackBarHeight: _lookingForCarDetail2PageStyles.widthDp * 15,
            inactiveTrackBarHeight: _lookingForCarDetail2PageStyles.widthDp * 15,
            activeDisabledTrackBarColor: LookingForCarDetail2PageColors.activeSliderColor,
            sliderBorderRadius: _lookingForCarDetail2PageStyles.widthDp * 10,
            sliderBorderColor: Colors.grey[400],
            inactiveDisabledTrackBarColor: Colors.white,
            tooltipDisabled: true,
            tooltipTextStyle: TextStyle(fontSize: _lookingForCarDetail2PageStyles.textFontSize * 0.8),
            tooltipBorderRadius: _lookingForCarDetail2PageStyles.widthDp * 10,
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
              _carModel.kilometer = double.parse(lowerValue.toString()).toInt();
            },
          ),

          /// --- hand ---
          SizedBox(height: _lookingForCarDetail2PageStyles.fieldSpacing),
          Text(
            "LookingForCarDetail2Page.handLabel".tr(),
            style: TextStyle(fontSize: _lookingForCarDetail2PageStyles.textFontSize),
          ),
          CustomSlideBar(
            width: double.infinity,
            height: _lookingForCarDetail2PageStyles.slideBarHeight,
            values: [Constants.handFrom.toDouble(), Constants.handTo.toDouble()],
            min: Constants.handFrom.toDouble(),
            max: Constants.handTo.toDouble(),
            activeTrackBarHeight: _lookingForCarDetail2PageStyles.widthDp * 15,
            inactiveTrackBarHeight: _lookingForCarDetail2PageStyles.widthDp * 15,
            activeDisabledTrackBarColor: LookingForCarDetail2PageColors.activeSliderColor,
            sliderBorderRadius: _lookingForCarDetail2PageStyles.widthDp * 10,
            sliderBorderColor: Colors.grey[400],
            inactiveDisabledTrackBarColor: Colors.white,
            tooltipDisabled: true,
            tooltipTextStyle: TextStyle(fontSize: _lookingForCarDetail2PageStyles.textFontSize * 0.8),
            tooltipBorderRadius: _lookingForCarDetail2PageStyles.widthDp * 10,
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
              _carModel.handFrom = double.parse(lowerValue.toString()).toInt();
              _carModel.handTo = double.parse(upperValue.toString()).toInt();
            },
          ),

          /// --- gear and auto
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: CustomCheckBox(
                  width: double.maxFinite,
                  height: null,
                  label: "LookingForCarDetail2Page.GearLabel".tr(),
                  labelFontSize: _lookingForCarDetail2PageStyles.textFontSize,
                  iconColor: LookingForCarDetail2PageColors.primaryColor,
                  onChanged: (value) {
                    _carModel.haveGear = value;
                  },
                ),
              ),
              Expanded(
                child: CustomCheckBox(
                  width: double.maxFinite,
                  height: null,
                  label: "LookingForCarDetail2Page.autoLabel".tr(),
                  labelFontSize: _lookingForCarDetail2PageStyles.textFontSize,
                  iconColor: LookingForCarDetail2PageColors.primaryColor,
                  onChanged: (value) {
                    _carModel.haveAuto = value;
                  },
                ),
              ),
            ],
          ),

          /// --- note
          SizedBox(height: _lookingForCarDetail2PageStyles.fieldSpacing),
          CustomTextFormField(
            width: double.maxFinite,
            height: _lookingForCarDetail2PageStyles.widthDp * 200,
            label: "LookingForCarDetail2Page.notesLabel".tr(),
            labelFontSize: _lookingForCarDetail2PageStyles.textFontSize,
            labelSpacing: _lookingForCarDetail2PageStyles.widthDp * 5,
            textFontSize: _lookingForCarDetail2PageStyles.textFontSize,
            hintText: "LookingForCarDetail2Page.notesHintText".tr(),
            hintTextColor: Colors.grey,
            hintTextFontSize: _lookingForCarDetail2PageStyles.textFontSize,
            border: Border.all(width: 1, color: Colors.black),
            errorBorder: Border.all(width: 1, color: Colors.red),
            borderRadius: _lookingForCarDetail2PageStyles.widthDp * 4,
            keyboardType: TextInputType.multiline,
            maxLines: 100,
            onChangeHandler: (input) => _carModel.notes = input.trim(),
            validatorHandler: (input) => (input.length < 10) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "10"}) : null,
            onSaveHandler: (input) => _carModel.notes = input.trim(),
          ),
          SizedBox(height: _lookingForCarDetail2PageStyles.fieldSpacing),
        ],
      ),
    );
  }

  Widget _containerNextStep(BuildContext context) {
    return CustomRaisedButton(
      width: double.infinity,
      height: _lookingForCarDetail2PageStyles.nextStepHeight,
      color: LookingForCarDetail2PageColors.primaryColor,
      borderColor: Colors.white,
      borderRadius: _lookingForCarDetail2PageStyles.widthDp * 10,
      child: Text(
        "LookingForCarDetail2Page.finishButtonText".tr(),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _lookingForCarDetail2PageStyles.nextStepTextFontSize, color: Colors.white),
      ),
      onPressed: () {
        finish(context);
      },
    );
  }

  void finish(BuildContext context) {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    Navigator.of(context).popUntil(ModalRoute.withName('/looking_for_page'));
    Navigator.of(context).pushNamed("/send_customer_info_page", arguments: {"carModel": _carModel});
  }
}
