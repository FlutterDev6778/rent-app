import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';

class AgentMainPageStyles {
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

  double titleFontSize;
  double textFontSize;

  double listItemTitelFontSize;
  double listItemTextFontSize;
  double listItemSpacing;
  double listItemHorizontalPadding;
  double listItemVerticalPadding;

  AgentMainPageStyles(BuildContext context) {}
}

class AgentMainPageMobileStyles extends AgentMainPageStyles {
  AgentMainPageMobileStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 25;
    primaryVerticalPadding = widthDp * 25;

    mainWidth = deviceWidth;
    mainHeight = safeAreaHeight;

    titleFontSize = fontSp * 20;
    textFontSize = fontSp * 18;

    listItemTitelFontSize = fontSp * 18;
    listItemTextFontSize = fontSp * 12;
    listItemSpacing = widthDp * 7;
    listItemHorizontalPadding = widthDp * 25;
    listItemVerticalPadding = widthDp * 12;
  }
}

class AgentMainPageTabletStyles extends AgentMainPageStyles {
  AgentMainPageTabletStyles(BuildContext context) : super(context) {
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

    titleFontSize = fontSp * 25;
    textFontSize = fontSp * 20;

    listItemTitelFontSize = fontSp * 20;
    listItemTextFontSize = fontSp * 16;
    listItemSpacing = widthDp * 7;
    listItemHorizontalPadding = widthDp * 25;
    listItemVerticalPadding = widthDp * 12;
  }
}

class AgentMainPageDesktopStyles extends AgentMainPageStyles {
  AgentMainPageDesktopStyles(BuildContext context) : super(context) {
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

    titleFontSize = fontSp * 25;
    textFontSize = fontSp * 20;

    listItemTitelFontSize = fontSp * 20;
    listItemTextFontSize = fontSp * 16;
    listItemSpacing = widthDp * 7;
    listItemHorizontalPadding = widthDp * 25;
    listItemVerticalPadding = widthDp * 12;
  }
}

class AgentMainPageLargeDesktopStyles extends AgentMainPageStyles {
  AgentMainPageLargeDesktopStyles(BuildContext context) : super(context) {
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

    titleFontSize = fontSp * 25;
    textFontSize = fontSp * 20;

    listItemTitelFontSize = fontSp * 20;
    listItemTextFontSize = fontSp * 16;
    listItemSpacing = widthDp * 7;
    listItemHorizontalPadding = widthDp * 25;
    listItemVerticalPadding = widthDp * 12;
  }
}
