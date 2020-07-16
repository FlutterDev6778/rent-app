import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rental/Pages/App/Styles/resposible_settings.dart';

class WelcomePageStyles {
  double devicePixelRatio;
  double deviceWidth;
  double deviceHeight;
  double statusbarHeight;
  double bottombarHeight;
  double appbarHeight;
  double safeAreaHeight;
  double shareWidth;
  double shareHeight;
  double widthDp;
  double heightDp;
  double fontSp;

  double primaryHorizontalPadding;
  double primaryVerticalPadding;

  double mainWidth;
  double mainHeight;

  double welcome1ImageSize;
  double welcome2ImageSize;

  double agentLoginButtonWidth;
  double agentLoginButtonHeight;
  double agentLoginButtontTextFontSize;

  double titleFontSize;
  double description1FontSize;
  double description2FontSize;

  double startButtonWidth;
  double startButtonHeight;
  double startButtonTextFontSize;

  WelcomePageStyles(BuildContext context) {}
}

class WelcomePageMobileStyles extends WelcomePageStyles {
  WelcomePageMobileStyles(BuildContext context) : super(context) {
    ScreenUtil.init(
      context,
      width: ResponsibleDesignSettings.mobileDesignWidth,
      height: ResponsibleDesignSettings.mobileDesignHeight,
      allowFontScaling: false,
    );

    devicePixelRatio = ScreenUtil.pixelRatio;
    deviceWidth = ScreenUtil.screenWidthDp;
    deviceHeight = ScreenUtil.screenHeightDp;
    statusbarHeight = ScreenUtil.statusBarHeight;
    appbarHeight = AppBar().preferredSize.height;
    bottombarHeight = ScreenUtil.bottomBarHeight;
    safeAreaHeight = deviceHeight - statusbarHeight - bottombarHeight;
    shareWidth = deviceWidth / 100;
    shareHeight = deviceHeight / 100;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setHeight(1);
    fontSp = ScreenUtil().setSp(1, allowFontScalingSelf: false);

    primaryHorizontalPadding = widthDp * 24;
    primaryVerticalPadding = widthDp * 24;

    mainWidth = deviceWidth;
    mainHeight = safeAreaHeight;

    welcome1ImageSize = mainWidth * 0.9;
    welcome2ImageSize = mainWidth * 0.6;

    agentLoginButtonWidth = widthDp * 132;
    agentLoginButtonHeight = agentLoginButtonWidth * 30 / 132;

    agentLoginButtontTextFontSize = fontSp * 18;

    titleFontSize = fontSp * 45;
    description1FontSize = fontSp * 22;
    description2FontSize = fontSp * 18;

    startButtonWidth = widthDp * 325;
    startButtonHeight = startButtonWidth * 53.36 / 325;
    startButtonTextFontSize = fontSp * 22;
  }
}

class WelcomePageTabletStyles extends WelcomePageStyles {
  WelcomePageTabletStyles(BuildContext context) : super(context) {
    devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    statusbarHeight = MediaQuery.of(context).padding.top;
    bottombarHeight = MediaQuery.of(context).viewInsets.bottom;
    appbarHeight = AppBar().preferredSize.height;
    safeAreaHeight = deviceHeight - statusbarHeight - appbarHeight;
    shareWidth = deviceWidth / 100;
    shareHeight = deviceHeight / 100;
    widthDp = 1;
    heightDp = 1;
    fontSp = 1;

    mainHeight = (deviceHeight < 600) ? 600 : deviceHeight;
    mainWidth = mainHeight / 2;
    primaryHorizontalPadding = widthDp * 30;
    primaryVerticalPadding = widthDp * 30;

    welcome1ImageSize = mainWidth * 0.9;
    welcome2ImageSize = mainWidth * 0.6;

    agentLoginButtonWidth = widthDp * 160;
    agentLoginButtonHeight = widthDp * 30;
    agentLoginButtontTextFontSize = fontSp * 1715;

    titleFontSize = fontSp * 1730;
    description1FontSize = fontSp * 1725;
    description2FontSize = fontSp * 1723;

    startButtonHeight = widthDp * 50;
    startButtonTextFontSize = fontSp * 17;
  }
}

class WelcomePageDesktopStyles extends WelcomePageStyles {
  WelcomePageDesktopStyles(BuildContext context) : super(context) {
    devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    statusbarHeight = MediaQuery.of(context).padding.top;
    bottombarHeight = MediaQuery.of(context).viewInsets.bottom;
    appbarHeight = AppBar().preferredSize.height;
    safeAreaHeight = deviceHeight - statusbarHeight - appbarHeight;
    shareWidth = deviceWidth / 100;
    shareHeight = deviceHeight / 100;
    widthDp = 1;
    heightDp = 1;
    fontSp = 1;

    mainHeight = (deviceHeight < 600) ? 600 : deviceHeight;
    mainWidth = mainHeight / 2;
    primaryHorizontalPadding = widthDp * 30;
    primaryVerticalPadding = widthDp * 30;

    welcome1ImageSize = mainWidth * 0.9;
    welcome2ImageSize = mainWidth * 0.6;

    agentLoginButtonWidth = widthDp * 160;
    agentLoginButtonHeight = widthDp * 30;
    agentLoginButtontTextFontSize = fontSp * 1715;

    titleFontSize = fontSp * 1730;
    description1FontSize = fontSp * 1725;
    description2FontSize = fontSp * 1723;

    startButtonHeight = widthDp * 50;
    startButtonTextFontSize = fontSp * 17;
  }
}

class WelcomePageLargeDesktopStyles extends WelcomePageStyles {
  WelcomePageLargeDesktopStyles(BuildContext context) : super(context) {
    ScreenUtil.init(
      context,
      width: ResponsibleDesignSettings.desktopDesignWidth,
      height: ResponsibleDesignSettings.desktopDesignHeight,
      allowFontScaling: false,
    );

    devicePixelRatio = ScreenUtil.pixelRatio;
    deviceWidth = ScreenUtil.screenWidthDp;
    deviceHeight = ScreenUtil.screenHeightDp;
    statusbarHeight = ScreenUtil.statusBarHeight;
    appbarHeight = AppBar().preferredSize.height;
    bottombarHeight = ScreenUtil.bottomBarHeight;
    safeAreaHeight = deviceHeight - statusbarHeight - bottombarHeight;
    shareWidth = deviceWidth / 100;
    shareHeight = deviceHeight / 100;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setHeight(1);
    fontSp = ScreenUtil().setSp(1, allowFontScalingSelf: false);

    mainHeight = (deviceHeight < 600) ? 600 : deviceHeight;
    mainWidth = mainHeight / 2;
    primaryHorizontalPadding = widthDp * 30;
    primaryVerticalPadding = widthDp * 30;

    welcome1ImageSize = mainWidth * 0.9;
    welcome2ImageSize = mainWidth * 0.6;

    agentLoginButtonWidth = widthDp * 160;
    agentLoginButtonHeight = widthDp * 30;
    agentLoginButtontTextFontSize = fontSp * 1715;

    titleFontSize = fontSp * 1730;
    description1FontSize = fontSp * 1725;
    description2FontSize = fontSp * 1723;

    startButtonHeight = widthDp * 50;
    startButtonTextFontSize = fontSp * 17;
  }
}
