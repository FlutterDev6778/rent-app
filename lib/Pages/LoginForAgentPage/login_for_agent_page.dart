import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/CustomWidgets/index.dart';
import 'package:rental/DataProviders/index.dart';
import 'package:rental/Models/agent_model.dart';
import 'package:rental/Pages/AgentMainPage/agent_main_page.dart';
import 'package:rental/Pages/App/Providers/index.dart';
import 'package:rental/Pages/App/Styles/index.dart';
import 'package:rental/Services/index.dart';
import 'package:rental/Utils/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/CustomWidgets/custom_text_form_field.dart';
import 'package:rental/CustomWidgets/custom_raised_button.dart';
import 'package:rental/Pages/SignupForAgentPage/signup_for_agent_page.dart';

class LoginForAgentPage extends StatelessWidget {
  LoginForAgentPageStyles _loginForAgentPageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginForAgentPageProvider _loginForAgentPageProvider;

  String _email, _password;

  Authentication _authentication = new Authentication();
  FirebaseUser _firebaseUser;

  AgentDataProvider _agentDataProvider = AgentDataProvider();
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  @override
  Widget build(BuildContext context) {
    _loginForAgentPageStyles = LoginForAgentPageStyles(context);
    _firebaseNotification.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginForAgentPageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _loginForAgentPageStyles = LoginForAgentPageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _loginForAgentPageStyles = LoginForAgentPageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _loginForAgentPageStyles = LoginForAgentPageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _loginForAgentPageStyles = LoginForAgentPageMobileStyles(context);
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
            width: _loginForAgentPageStyles.deviceWidth,
            color: (_loginForAgentPageStyles.runtimeType == LoginForAgentPageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _loginForAgentPageStyles.mainWidth,
      alignment: Alignment.topCenter,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _loginForAgentPageStyles.primaryHorizontalPadding,
        vertical: _loginForAgentPageStyles.primaryVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: _loginForAgentPageStyles.heightDp * 25),
          Image.asset(
            LoginForAgentPageAssets.loginImage,
            width: _loginForAgentPageStyles.loginImageSize,
            height: _loginForAgentPageStyles.loginImageSize,
          ),
          SizedBox(height: _loginForAgentPageStyles.heightDp * 25),
          _containerWelcomeLable(context),
          SizedBox(height: _loginForAgentPageStyles.heightDp * 25),
          _containerForm(context),
          SizedBox(height: _loginForAgentPageStyles.heightDp * 15),
          _containerSelectAgent(context),
          SizedBox(height: _loginForAgentPageStyles.heightDp * 15),
          _containerLoginButton(context),
          SizedBox(height: _loginForAgentPageStyles.heightDp * 12),
          _containerSignupLink(context),
        ],
      ),
    );
  }

  Widget _containerWelcomeLable(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(LoginForAgentPageString.welcomeTitle, style: TextStyle(fontSize: _loginForAgentPageStyles.titleFontSize)),
        SizedBox(height: _loginForAgentPageStyles.heightDp * 8),
        Text(LoginForAgentPageString.welcomeDescription, style: TextStyle(fontSize: _loginForAgentPageStyles.textFontSize)),
      ],
    );
  }

  Widget _containerForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomTextFormField(
            width: double.infinity,
            height: _loginForAgentPageStyles.fieldItemHeight,
            textFontSize: _loginForAgentPageStyles.textFontSize,
            border: Border.all(width: 1, color: Colors.black),
            errorBorder: Border.all(width: 1, color: Colors.red),
            borderRadius: 4,
            hintText: LoginForAgentPageString.emailHintText,
            keyboardType: TextInputType.emailAddress,
            validatorHandler: (input) => (!Validators.isValidEmail(input)) ? ValidateErrorString.emailErrorText : null,
            onSaveHandler: (input) => _email = input.trim(),
          ),
          CustomTextFormField(
            width: double.infinity,
            height: _loginForAgentPageStyles.fieldItemHeight,
            textFontSize: _loginForAgentPageStyles.textFontSize,
            hintText: LoginForAgentPageString.passwordHintText,
            border: Border.all(width: 1, color: Colors.black),
            errorBorder: Border.all(width: 1, color: Colors.red),
            borderRadius: 4,
            obscureText: true,
            validatorHandler: (input) => (input.length < 6) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "6"}) : null,
            onSaveHandler: (input) => _password = input.trim(),
          )
        ],
      ),
    );
  }

  Widget _containerSelectAgent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(LoginForAgentPageString.agentTitle, style: TextStyle(fontSize: _loginForAgentPageStyles.agentTitleFontSize)),
        SizedBox(height: _loginForAgentPageStyles.heightDp * 10),
        Consumer<LoginForAgentPageProvider>(
          builder: (context, loginForAgentPageProvider, _) {
            _loginForAgentPageProvider = loginForAgentPageProvider;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    loginForAgentPageProvider.setSelectCategory(1);
                  },
                  child: Container(
                    width: _loginForAgentPageStyles.categorySize,
                    height: _loginForAgentPageStyles.categorySize,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: (loginForAgentPageProvider.selectCategory == 1) ? LoginForAgentPageColors.selectedCategoryBorderColor : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      LoginForAgentPageAssets.carImage,
                      width: _loginForAgentPageStyles.categorySize * 0.55,
                      height: _loginForAgentPageStyles.categorySize * 0.55,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    loginForAgentPageProvider.setSelectCategory(2);
                  },
                  child: Container(
                    width: _loginForAgentPageStyles.categorySize,
                    height: _loginForAgentPageStyles.categorySize,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: (loginForAgentPageProvider.selectCategory == 2) ? LoginForAgentPageColors.selectedCategoryBorderColor : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      LoginForAgentPageAssets.houseImage,
                      width: _loginForAgentPageStyles.categorySize * 0.6,
                      height: _loginForAgentPageStyles.categorySize * 0.6,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _containerLoginButton(BuildContext context) {
    return Consumer<LoginForAgentPageProvider>(builder: (context, loginForAgentPageProvider, _) {
      return Column(
        children: [
          CustomRaisedButton(
            width: double.infinity,
            height: _loginForAgentPageStyles.loginButtonHeight,
            color: LoginForAgentPageColors.primaryColor,
            borderColor: Colors.white,
            borderRadius: 10,
            child: Text(
              LoginForAgentPageString.loginButtonText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _loginForAgentPageStyles.loginButtonTextFontSize, color: Colors.white),
            ),
            onPressed: () {
              _login(context);
            },
          ),
          (loginForAgentPageProvider.errorString != "") ? SizedBox(height: _loginForAgentPageStyles.widthDp * 3) : SizedBox(),
          (loginForAgentPageProvider.errorString != "")
              ? Text(
                  loginForAgentPageProvider.errorString,
                  style: TextStyle(fontSize: _loginForAgentPageStyles.textFontSize * 0.8, color: Colors.red),
                )
              : SizedBox(),
        ],
      );
    });
  }

  Widget _containerSignupLink(BuildContext context) {
    return InkWell(
      child: Text(
        LoginForAgentPageString.signupLink,
        style: TextStyle(fontSize: _loginForAgentPageStyles.textFontSize, color: LoginForAgentPageColors.signupLinkColor),
      ),
      onTap: () {
        if (_loginForAgentPageProvider.selectCategory == null) {
          _loginForAgentPageProvider.setErrorString(LoginForAgentPageString.selectCategoryErrorString);
          return;
        }

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => SignupForAgentPage(
              category: _loginForAgentPageProvider.selectCategory,
            ),
          ),
        );
      },
    );
  }

  void _login(BuildContext context) async {
    // if (_loginForAgentPageProvider.selectCategory == null) {
    //   _loginForAgentPageProvider.setErrorString(LoginForAgentPageString.selectCategoryErrorString);
    //   return;
    // }
    _loginForAgentPageProvider.setErrorString("");
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();

    AgentModel agentModel;

    await CustomProgressDialog.of(context: context, width: _loginForAgentPageStyles.shareWidth * 80).show();

    var result = await _authentication.signIn(email: _email, password: _password);
    if (result["state"] == "success") {
      var result = (await _agentDataProvider.getAgentData(wheres: [
        {"key": "email", "val": _email},
        {"key": "password", "val": _password},
      ]));

      if (result == null) {
        _loginForAgentPageProvider.setErrorString(LoginForAgentPageString.loginFailedString);
      } else if (result.length == 0) {
        _loginForAgentPageProvider.setErrorString(LoginForAgentPageString.noExistUserString);
      } else if (result.length != 0 && result[0].isApproved == false) {
        _loginForAgentPageProvider.setErrorString(LoginForAgentPageString.approvedErrorString);
      } else {
        agentModel = result[0];
        var newToken = await _firebaseNotification.getToken();
        if (agentModel.token != newToken) {
          agentModel.token = newToken;
          var result = await _agentDataProvider.updateAgent(agentModel: agentModel);
          if (!result) {
            agentModel = null;
          }
        }
      }
    } else {
      _loginForAgentPageProvider.setErrorString(result["errorString"]);
    }

    await CustomProgressDialog.of(context: context, width: _loginForAgentPageStyles.shareWidth * 80).hide();
    if (agentModel != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => AgentMainPage(
            category: agentModel.category,
            agentModel: agentModel,
          ),
        ),
        ModalRoute.withName('/login_for_agent_page'),
      );
    }
  }
}
