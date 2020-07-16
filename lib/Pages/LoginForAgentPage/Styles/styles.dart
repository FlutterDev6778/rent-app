import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';

class LoginForAgentPageStyles {
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

  double loginImageSize;
  double categorySize;

  double titleFontSize;
  double agentTitleFontSize;
  double textFontSize;
  double fieldSpacing;
  double fieldItemHeight;
  double loginButtonHeight;
  double loginButtonTextFontSize;

  LoginForAgentPageStyles(BuildContext context) {}
}

class LoginForAgentPageMobileStyles extends LoginForAgentPageStyles {
  LoginForAgentPageMobileStyles(BuildContext context) : super(context) {
    ScreenUtil.init(context,
        width: ResponsibleDesignSettings.mobileDesignWidth, height: ResponsibleDesignSettings.mobileDesignHeight, allowFontScaling: false);

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

    primaryHorizontalPadding = widthDp * 25;
    primaryVerticalPadding = widthDp * 25;

    mainWidth = deviceWidth;
    mainHeight = safeAreaHeight;

    loginImageSize = widthDp * 169.96;
    categorySize = widthDp * 104;

    titleFontSize = fontSp * 24;
    agentTitleFontSize = fontSp * 20;
    textFontSize = fontSp * 16;
    fieldSpacing = widthDp * 25;
    fieldItemHeight = widthDp * 53.36;

    loginButtonHeight = widthDp * 53.36;
    loginButtonTextFontSize = fontSp * 20;
  }
}

class LoginForAgentPageTabletStyles extends LoginForAgentPageStyles {
  LoginForAgentPageTabletStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 25;
    primaryVerticalPadding = widthDp * 25;

    loginImageSize = mainWidth * 0.5;
    categorySize = mainWidth / 5 * 2;

    titleFontSize = fontSp * 25;
    agentTitleFontSize = fontSp * 21;
    textFontSize = fontSp * 17;
    fieldSpacing = widthDp * 20;
    fieldItemHeight = widthDp * 50;

    loginButtonHeight = widthDp * 50;
    loginButtonTextFontSize = fontSp * 17;
  }
}

class LoginForAgentPageDesktopStyles extends LoginForAgentPageStyles {
  LoginForAgentPageDesktopStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 25;
    primaryVerticalPadding = widthDp * 25;

    loginImageSize = mainWidth * 0.5;
    categorySize = mainWidth / 5 * 2;

    titleFontSize = fontSp * 25;
    agentTitleFontSize = fontSp * 21;
    textFontSize = fontSp * 17;
    fieldSpacing = widthDp * 20;
    fieldItemHeight = widthDp * 50;

    loginButtonHeight = widthDp * 50;
    loginButtonTextFontSize = fontSp * 17;
  }
}

class LoginForAgentPageLargeDesktopStyles extends LoginForAgentPageStyles {
  LoginForAgentPageLargeDesktopStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 25;
    primaryVerticalPadding = widthDp * 25;

    loginImageSize = mainWidth * 0.5;
    categorySize = mainWidth / 5 * 2;

    titleFontSize = fontSp * 25;
    agentTitleFontSize = fontSp * 21;
    textFontSize = fontSp * 17;
    fieldSpacing = widthDp * 20;
    fieldItemHeight = widthDp * 50;

    loginButtonHeight = widthDp * 50;
    loginButtonTextFontSize = fontSp * 17;
  }
}
