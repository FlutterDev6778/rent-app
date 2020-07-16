import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/Pages/App/Providers/app_data_provider.dart';
import 'package:rental/Services/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/CustomWidgets/custom_raised_button.dart';

class WelcomePage extends StatelessWidget {
  WelcomePageStyles _welcomePageStyles;
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  @override
  Widget build(BuildContext context) {
    _welcomePageStyles = WelcomePageStyles(context);
    _firebaseNotification.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WelcomePageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _welcomePageStyles = WelcomePageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _welcomePageStyles = WelcomePageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _welcomePageStyles = WelcomePageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _welcomePageStyles = WelcomePageMobileStyles(context);
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
            width: _welcomePageStyles.deviceWidth,
            color: (_welcomePageStyles.runtimeType == WelcomePageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _welcomePageStyles.mainWidth,
      height: _welcomePageStyles.mainHeight,
      alignment: Alignment.topCenter,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              WelcomePageAssets.welcome2Image,
              width: _welcomePageStyles.welcome2ImageSize,
              height: _welcomePageStyles.welcome2ImageSize,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              WelcomePageAssets.welcome1Image,
              width: _welcomePageStyles.welcome1ImageSize,
              height: _welcomePageStyles.welcome1ImageSize,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                width: _welcomePageStyles.mainWidth,
                height: _welcomePageStyles.mainHeight,
                padding: EdgeInsets.symmetric(
                  horizontal: _welcomePageStyles.primaryHorizontalPadding,
                  vertical: _welcomePageStyles.primaryVerticalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomRaisedButton(
                      width: _welcomePageStyles.agentLoginButtonWidth,
                      height: _welcomePageStyles.agentLoginButtonHeight,
                      color: WelcomePageColors.agentLoginButtonColor,
                      borderColor: Colors.white,
                      borderRadius: _welcomePageStyles.agentLoginButtonHeight / 2,
                      child: Text(
                        WelcomePageString.agentLoginButtonText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: _welcomePageStyles.agentLoginButtontTextFontSize, color: Colors.white),
                      ),
                      onPressed: () async {
                        await Navigator.of(context).pushNamed('/login_for_agent_page');
                        _firebaseNotification.init(context);
                      },
                    ),
                    SizedBox(height: _welcomePageStyles.welcome2ImageSize / 2),
                    Center(
                      child: Text(
                        WelcomePageString.title,
                        style: TextStyle(fontSize: _welcomePageStyles.titleFontSize),
                      ),
                    ),
                    SizedBox(height: _welcomePageStyles.description1FontSize),
                    Center(
                      child: Text(
                        WelcomePageString.description1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: _welcomePageStyles.description1FontSize),
                      ),
                    ),
                    SizedBox(height: _welcomePageStyles.description1FontSize),
                    Center(
                      child: Text(
                        WelcomePageString.description2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: _welcomePageStyles.description2FontSize),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    CustomRaisedButton(
                      width: double.infinity,
                      height: _welcomePageStyles.startButtonHeight,
                      color: WelcomePageColors.primaryColor,
                      borderColor: WelcomePageColors.primaryColor,
                      borderRadius: 10,
                      child: Text(
                        WelcomePageString.startButtonText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: _welcomePageStyles.startButtonTextFontSize, color: Colors.white),
                      ),
                      onPressed: () async {
                        await Navigator.of(context).pushNamed("/looking_for_page");
                        _firebaseNotification.init(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
