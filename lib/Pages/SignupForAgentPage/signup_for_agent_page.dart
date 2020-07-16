import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rental/DataProviders/index.dart';
import 'package:rental/Pages/App/Providers/index.dart';
import 'package:rental/Pages/App/Styles/index.dart';
import 'package:rental/Services/index.dart';
import 'package:rental/Utils/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/CustomWidgets/index.dart';
import 'package:rental/Models/agent_model.dart';
import 'package:rental/Pages/LoginForAgentPage/login_for_agent_page.dart';

class SignupForAgentPage extends StatelessWidget {
  SignupForAgentPage({this.category});

  SignupForAgentPageStyles _signupForAgentPageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int category;
  AgentModel _agentModel = AgentModel();
  Authentication _authentication = new Authentication();
  FirebaseNotification _firebaseNotification = FirebaseNotification();
  FirebaseUser _firebaseUser;

  AgentDataProvider _agentDataProvider = AgentDataProvider();

  @override
  Widget build(BuildContext context) {
    _signupForAgentPageStyles = SignupForAgentPageStyles(context);
    _firebaseNotification.init(context);
    _agentModel.category = category;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupForAgentPageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _signupForAgentPageStyles = SignupForAgentPageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _signupForAgentPageStyles = SignupForAgentPageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _signupForAgentPageStyles = SignupForAgentPageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _signupForAgentPageStyles = SignupForAgentPageMobileStyles(context);
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
            width: _signupForAgentPageStyles.deviceWidth,
            color: (_signupForAgentPageStyles.runtimeType == SignupForAgentPageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _signupForAgentPageStyles.mainWidth,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _signupForAgentPageStyles.primaryHorizontalPadding,
        vertical: _signupForAgentPageStyles.primaryVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _containerForm(context),
          SizedBox(height: _signupForAgentPageStyles.fieldSpacing),
          _containerSignupButton(context),
          SizedBox(height: _signupForAgentPageStyles.fieldSpacing),
          _containerLoginLink(context),
        ],
      ),
    );
  }

  Widget _containerForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            SignupForAgentPageString.title,
            style: TextStyle(fontSize: _signupForAgentPageStyles.titleFontSize),
          ),
          SizedBox(height: _signupForAgentPageStyles.fieldSpacing),

          /// --- agent name
          CustomTextFormField(
            width: double.infinity,
            height: _signupForAgentPageStyles.fieldItemHeight,
            label: (_agentModel.category == 1) ? SignupForAgentPageString.agentNameForCarLabel : SignupForAgentPageString.agentNameForHouseLabel,
            labelFontSize: _signupForAgentPageStyles.textFontSize,
            labelSpacing: _signupForAgentPageStyles.widthDp * 5,
            textFontSize: _signupForAgentPageStyles.textFontSize,
            border: Border.all(width: 1, color: Colors.black),
            errorBorder: Border.all(width: 1, color: Colors.red),
            borderRadius: 4,
            fixedHeightState: true,
            validatorHandler: (input) => (input.length < 3) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "3"}) : null,
            onSaveHandler: (input) => _agentModel.agentName = input.trim(),
          ),

          /// --- email
          CustomTextFormField(
            width: double.infinity,
            height: _signupForAgentPageStyles.fieldItemHeight,
            label: SignupForAgentPageString.emailLabel,
            labelFontSize: _signupForAgentPageStyles.textFontSize,
            labelSpacing: _signupForAgentPageStyles.widthDp * 5,
            textFontSize: _signupForAgentPageStyles.textFontSize,
            border: Border.all(width: 1, color: Colors.black),
            errorBorder: Border.all(width: 1, color: Colors.red),
            borderRadius: 4,
            keyboardType: TextInputType.emailAddress,
            fixedHeightState: true,
            validatorHandler: (input) => (!Validators.isValidEmail(input)) ? ValidateErrorString.emailErrorText : null,
            onSaveHandler: (input) => _agentModel.email = input.trim(),
          ),

          /// --- Phone
          CustomTextFormField(
            width: double.infinity,
            height: _signupForAgentPageStyles.fieldItemHeight,
            label: SignupForAgentPageString.phoneLabel,
            labelFontSize: _signupForAgentPageStyles.textFontSize,
            labelSpacing: _signupForAgentPageStyles.widthDp * 5,
            textFontSize: _signupForAgentPageStyles.textFontSize,
            border: Border.all(width: 1, color: Colors.black),
            errorBorder: Border.all(width: 1, color: Colors.red),
            borderRadius: 4,
            keyboardType: TextInputType.number,
            fixedHeightState: true,
            validatorHandler: (input) => (input.length < 8) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "8"}) : null,
            onSaveHandler: (input) => _agentModel.phoneNumber = input.trim(),
          ),

          /// --- passwordLabel
          Consumer<SignupForAgentPageProvider>(
            builder: (context, signupForAgentPageProvider, _) {
              return CustomTextFormField(
                width: double.infinity,
                height: _signupForAgentPageStyles.fieldItemHeight,
                label: SignupForAgentPageString.passwordLabel,
                labelFontSize: _signupForAgentPageStyles.textFontSize,
                labelSpacing: _signupForAgentPageStyles.widthDp * 5,
                textFontSize: _signupForAgentPageStyles.textFontSize,
                border: Border.all(width: 1, color: Colors.black),
                errorBorder: Border.all(width: 1, color: Colors.red),
                borderRadius: 4,
                fixedHeightState: true,
                obscureText: true,
                onChangeHandler: (input) => _agentModel.password = input,
                validatorHandler: (input) => (input.length < 6)
                    ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "6"})
                    : (_agentModel.password != signupForAgentPageProvider.confirmPassword) ? ValidateErrorString.passwordMatchErrorText : null,
                onSaveHandler: (input) => _agentModel.password = input.trim(),
              );
            },
          ),

          /// --- ConfirmPasswordLabel
          Consumer<SignupForAgentPageProvider>(
            builder: (context, signupForAgentPageProvider, _) {
              return CustomTextFormField(
                width: double.infinity,
                height: _signupForAgentPageStyles.fieldItemHeight,
                label: SignupForAgentPageString.confirmPasswordLabel,
                labelFontSize: _signupForAgentPageStyles.textFontSize,
                labelSpacing: _signupForAgentPageStyles.widthDp * 5,
                textFontSize: _signupForAgentPageStyles.textFontSize,
                border: Border.all(width: 1, color: Colors.black),
                errorBorder: Border.all(width: 1, color: Colors.red),
                borderRadius: 4,
                fixedHeightState: true,
                obscureText: true,
                onChangeHandler: (input) => signupForAgentPageProvider.setConfirmPassword(input),
                validatorHandler: (input) => (input.length < 6)
                    ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "6"})
                    : (_agentModel.password != signupForAgentPageProvider.confirmPassword) ? ValidateErrorString.passwordMatchErrorText : null,
              );
            },
          ),

          /// --- Address
          (_agentModel.category == 1)
              ? CustomTextFormField(
                  width: double.infinity,
                  height: _signupForAgentPageStyles.fieldItemHeight,
                  label: (_agentModel.category == 1) ? SignupForAgentPageString.addressLabel : SignupForAgentPageString.cityLabel,
                  labelFontSize: _signupForAgentPageStyles.textFontSize,
                  labelSpacing: _signupForAgentPageStyles.widthDp * 5,
                  textFontSize: _signupForAgentPageStyles.textFontSize,
                  border: Border.all(width: 1, color: Colors.black),
                  errorBorder: Border.all(width: 1, color: Colors.red),
                  borderRadius: 4,
                  fixedHeightState: true,
                  validatorHandler: (input) => (input.length < 3) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "3"}) : null,
                  onSaveHandler: (input) => _agentModel.address = input.trim(),
                )
              : CustomTextFormField(
                  width: double.infinity,
                  height: _signupForAgentPageStyles.fieldItemHeight,
                  label: (_agentModel.category == 1) ? SignupForAgentPageString.addressLabel : SignupForAgentPageString.cityLabel,
                  labelFontSize: _signupForAgentPageStyles.textFontSize,
                  labelSpacing: _signupForAgentPageStyles.widthDp * 5,
                  textFontSize: _signupForAgentPageStyles.textFontSize,
                  border: Border.all(width: 1, color: Colors.black),
                  errorBorder: Border.all(width: 1, color: Colors.red),
                  borderRadius: 4,
                  fixedHeightState: true,
                  validatorHandler: (input) => (input.length < 3) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "3"}) : null,
                  onSaveHandler: (input) => _agentModel.city = input.trim(),
                ),

          /// --- numOfCars
          (_agentModel.category == 1)
              ? CustomTextFormField(
                  width: double.infinity,
                  height: _signupForAgentPageStyles.fieldItemHeight,
                  label: (_agentModel.category == 1) ? SignupForAgentPageString.numOfCars : "",
                  labelFontSize: _signupForAgentPageStyles.textFontSize,
                  labelSpacing: _signupForAgentPageStyles.widthDp * 5,
                  textFontSize: _signupForAgentPageStyles.textFontSize,
                  border: Border.all(width: 1, color: Colors.black),
                  errorBorder: Border.all(width: 1, color: Colors.red),
                  borderRadius: 4,
                  fixedHeightState: true,
                  keyboardType: TextInputType.number,
                  validatorHandler: (input) => (input.length < 1) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "1"}) : null,
                  onSaveHandler: (input) => _agentModel.numOfCars = input.trim(),
                )
              : SizedBox(),

          // --- isRentProportiesLabel
          (_agentModel.category == 2)
              ? Text(
                  SignupForAgentPageString.isRentProportiesLabel,
                  style: TextStyle(fontSize: _signupForAgentPageStyles.textFontSize),
                )
              : SizedBox(),
          (_agentModel.category == 2)
              ? SizedBox(
                  height: _signupForAgentPageStyles.widthDp * 5,
                )
              : SizedBox(),
          (_agentModel.category == 2)
              ? Consumer<SignupForAgentPageProvider>(
                  builder: (context, signupForAgentPageProvider, _) {
                    print("____________${_agentModel.isRentProperties}________________");
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: CustomCheckBox(
                            width: double.maxFinite,
                            height: null,
                            label: SignupForAgentPageString.yesLabel,
                            labelFontSize: _signupForAgentPageStyles.textFontSize,
                            iconColor: SignupForAgentPageColors.primaryColor,
                            value: (_agentModel.isRentProperties == true) ? true : false,
                            stateChangePossible: false,
                            onChanged: (value) {
                              if (value)
                                _agentModel.isRentProperties = true;
                              else
                                _agentModel.isRentProperties = false;
                              signupForAgentPageProvider.refresh();
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomCheckBox(
                            width: double.maxFinite,
                            height: null,
                            label: SignupForAgentPageString.noLabel,
                            labelFontSize: _signupForAgentPageStyles.textFontSize,
                            iconColor: SignupForAgentPageColors.primaryColor,
                            value: (_agentModel.isRentProperties == false) ? true : false,
                            stateChangePossible: false,
                            onChanged: (value) {
                              if (value)
                                _agentModel.isRentProperties = false;
                              else
                                _agentModel.isRentProperties = true;
                              signupForAgentPageProvider.refresh();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )
              : SizedBox(),
          (_agentModel.category == 2)
              ? SizedBox(
                  height: _signupForAgentPageStyles.widthDp * 5,
                )
              : SizedBox(),
          // --- isEstateAgent
          (_agentModel.category == 2)
              ? Text(
                  SignupForAgentPageString.title,
                  style: TextStyle(fontSize: _signupForAgentPageStyles.textFontSize),
                )
              : SizedBox(),
          (_agentModel.category == 2)
              ? SizedBox(
                  height: _signupForAgentPageStyles.widthDp * 5,
                )
              : SizedBox(),
          (_agentModel.category == 2)
              ? Consumer<SignupForAgentPageProvider>(
                  builder: (context, signupForAgentPageProvider, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: CustomCheckBox(
                            width: double.maxFinite,
                            height: null,
                            label: SignupForAgentPageString.yesLabel,
                            labelFontSize: _signupForAgentPageStyles.textFontSize,
                            iconColor: SignupForAgentPageColors.primaryColor,
                            value: (_agentModel.isEstateAgent == true) ? true : false,
                            stateChangePossible: false,
                            onChanged: (value) {
                              if (value)
                                _agentModel.isEstateAgent = true;
                              else
                                _agentModel.isEstateAgent = false;
                              signupForAgentPageProvider.refresh();
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomCheckBox(
                            width: double.maxFinite,
                            height: null,
                            label: SignupForAgentPageString.noLabel,
                            labelFontSize: _signupForAgentPageStyles.textFontSize,
                            iconColor: SignupForAgentPageColors.primaryColor,
                            value: (_agentModel.isEstateAgent == false) ? true : false,
                            stateChangePossible: false,
                            onChanged: (value) {
                              if (value)
                                _agentModel.isEstateAgent = false;
                              else
                                _agentModel.isEstateAgent = true;

                              signupForAgentPageProvider.refresh();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )
              : SizedBox(),
          (_agentModel.category == 2)
              ? SizedBox(
                  height: _signupForAgentPageStyles.widthDp * 5,
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _containerSignupButton(BuildContext context) {
    return Consumer<SignupForAgentPageProvider>(builder: (context, signupForAgentPageProvider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRaisedButton(
            width: double.infinity,
            height: _signupForAgentPageStyles.signupButtonHeight,
            color: SignupForAgentPageColors.primaryColor,
            borderColor: Colors.white,
            borderRadius: 10,
            child: Text(
              SignupForAgentPageString.signupButtonText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _signupForAgentPageStyles.signupButtonTextFontSize, color: Colors.white),
            ),
            onPressed: () {
              _signup(context);
            },
          ),
          SizedBox(height: _signupForAgentPageStyles.widthDp * 5),
          (signupForAgentPageProvider.errorString != "")
              ? Text(
                  signupForAgentPageProvider.errorString,
                  style: TextStyle(fontSize: _signupForAgentPageStyles.textFontSize * 0.8, color: Colors.red),
                )
              : SizedBox(),
        ],
      );
    });
  }

  Widget _containerLoginLink(BuildContext context) {
    return InkWell(
      child: Text(SignupForAgentPageString.loginLink, style: TextStyle(fontSize: _signupForAgentPageStyles.textFontSize)),
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => LoginForAgentPage(),
          ),
        );
      },
    );
  }

  void _signup(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    var result;
    AgentModel newAgentModel;

    await CustomProgressDialog.of(
      context: context,
      width: _signupForAgentPageStyles.shareWidth * 80,
    ).show();

    result = await _authentication.signUp(email: _agentModel.email, password: _agentModel.password);
    if (result["state"] == "success") {
      /// FCM Token
      _agentModel.category = category;
      _agentModel.uid = result["user"].uid;
      _agentModel.token = await _firebaseNotification.getToken();
      _agentModel.ts = DateTime.now().millisecondsSinceEpoch;
      newAgentModel = await _agentDataProvider.addAgent(agentModel: _agentModel);
    } else {
      SignupForAgentPageProvider.of(context).setErrorString(result["errorString"]);
    }

    await CustomProgressDialog.of(context: context).hide();
    if (newAgentModel != null) {
      Navigator.of(context).pushReplacementNamed("/signup_final_page");
    }
  }
}
