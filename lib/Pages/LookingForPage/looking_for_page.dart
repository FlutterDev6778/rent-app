import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/Services/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/CustomWidgets/custom_raised_button.dart';

class LookingForPage extends StatelessWidget {
  LookingForPageStyles _lookingForPageStyles;
  LookingForPageProvider _lookingForPageProvider;
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  @override
  Widget build(BuildContext context) {
    _lookingForPageStyles = LookingForPageStyles(context);
    _firebaseNotification.init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LookingForPageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _lookingForPageStyles = LookingForPageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _lookingForPageStyles = LookingForPageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _lookingForPageStyles = LookingForPageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _lookingForPageStyles = LookingForPageMobileStyles(context);
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
            width: _lookingForPageStyles.deviceWidth,
            color: (_lookingForPageStyles.runtimeType == LookingForPageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _lookingForPageStyles.mainWidth,
      height: _lookingForPageStyles.mainHeight,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _lookingForPageStyles.primaryHorizontalPadding,
        vertical: _lookingForPageStyles.primaryVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _containerHeader(context),
          Expanded(child: _containerSelectAgent(context)),
          Center(
            child: Text(
              LookingForPageString.headerText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _lookingForPageStyles.titleFontSize),
            ),
          ),
          SizedBox(height: 50),
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
            child: Icon(Icons.arrow_back_ios, size: _lookingForPageStyles.textFontSize, color: Colors.black),
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.arrow_forward_ios, size: _lookingForPageStyles.textFontSize, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _containerSelectAgent(BuildContext context) {
    return Consumer<LookingForPageProvider>(
      builder: (context, loginForAgentPageProvider, _) {
        _lookingForPageProvider = loginForAgentPageProvider;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                loginForAgentPageProvider.setSelectCategory(1);
              },
              child: Container(
                width: _lookingForPageStyles.categorySize,
                height: _lookingForPageStyles.categorySize,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: (loginForAgentPageProvider.selectCategory == 1) ? LookingForPageColors.selectedCategoryBorderColor : Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  LookingForPageAssets.carImage,
                  width: _lookingForPageStyles.categorySize * 0.6,
                  height: _lookingForPageStyles.categorySize * 0.6,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                loginForAgentPageProvider.setSelectCategory(2);
              },
              child: Container(
                width: _lookingForPageStyles.categorySize,
                height: _lookingForPageStyles.categorySize,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: (loginForAgentPageProvider.selectCategory == 2) ? LookingForPageColors.selectedCategoryBorderColor : Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  LookingForPageAssets.houseImage,
                  width: _lookingForPageStyles.categorySize * 0.6,
                  height: _lookingForPageStyles.categorySize * 0.6,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _containerNextStep(BuildContext context) {
    return CustomRaisedButton(
      width: double.infinity,
      height: _lookingForPageStyles.nextStepHeight,
      color: LookingForPageColors.primaryColor,
      borderColor: Colors.white,
      borderRadius: 10,
      child: Text(
        LookingForPageString.nextStepButtonText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _lookingForPageStyles.nextStepTextFontSize, color: Colors.white),
      ),
      onPressed: () {
        nextStop(context);
      },
    );
  }

  void nextStop(BuildContext context) async {
    if (_lookingForPageProvider.selectCategory == null) return;
    if (_lookingForPageProvider.selectCategory == 1)
      await Navigator.of(context).pushNamed("/looking_for_car_detail1_page");
    else
      await Navigator.of(context).pushNamed("/looking_for_house_detail1_page");
    _firebaseNotification.init(context);
  }
}
