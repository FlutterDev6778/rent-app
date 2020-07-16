import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/Services/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/CustomWidgets/custom_raised_button.dart';
import 'package:rental/CustomWidgets/custom_checkbox.dart';
import 'package:rental/CustomWidgets/custom_text_form_field.dart';
import 'package:rental/Models/agent_model.dart';
import 'package:rental/Pages/LoginForAgentPage/login_for_agent_page.dart';

class SignupFinalPage extends StatelessWidget {
  SignupFinalPage({this.category});

  SignupFinalPageStyles _signupFinalPageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int category;
  AgentModel _agentModel = AgentModel();
  String _confirmPassword;
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  @override
  Widget build(BuildContext context) {
    _signupFinalPageStyles = SignupFinalPageStyles(context);
    _firebaseNotification.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupFinalPageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _signupFinalPageStyles = SignupFinalPageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _signupFinalPageStyles = SignupFinalPageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _signupFinalPageStyles = SignupFinalPageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _signupFinalPageStyles = SignupFinalPageMobileStyles(context);
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
            width: _signupFinalPageStyles.deviceWidth,
            color: (_signupFinalPageStyles.runtimeType == SignupFinalPageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _signupFinalPageStyles.mainWidth,
      height: _signupFinalPageStyles.mainHeight,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _signupFinalPageStyles.primaryHorizontalPadding,
        vertical: _signupFinalPageStyles.primaryVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _signupFinalPageStyles.primaryHorizontalPadding),
              alignment: Alignment.center,
              child: Text(
                SignupFinalPageString.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: _signupFinalPageStyles.titleFontSize),
              ),
            ),
          ),
          SizedBox(height: _signupFinalPageStyles.primaryVerticalPadding * 8),
          _containerSignupButton(context),
        ],
      ),
    );
  }

  Widget _containerSignupButton(BuildContext context) {
    return CustomRaisedButton(
      width: double.infinity,
      height: _signupFinalPageStyles.signupButtonHeight,
      color: SignupFinalPageColors.primaryColor,
      borderColor: Colors.white,
      borderRadius: 10,
      child: Text(
        SignupFinalPageString.finishButtonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _signupFinalPageStyles.signupButtonTextFontSize, color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed("/welcome_page");
      },
    );
  }
}
