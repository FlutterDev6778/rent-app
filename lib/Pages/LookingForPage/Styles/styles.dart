import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';

class LookingForPageStyles {
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

  double categorySize;

  double nextStepHeight;
  double nextStepTextFontSize;

  LookingForPageStyles(BuildContext context) {}
}

class LookingForPageMobileStyles extends LookingForPageStyles {
  LookingForPageMobileStyles(BuildContext context) : super(context) {
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

    titleFontSize = fontSp * 24;
    textFontSize = fontSp * 17;

    categorySize = widthDp * 150;

    nextStepHeight = widthDp * 53.36;
    nextStepTextFontSize = fontSp * 20;
  }
}

class LookingForPageTabletStyles extends LookingForPageStyles {
  LookingForPageTabletStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 25;
    primaryVerticalPadding = widthDp * 25;

    mainHeight = (deviceHeight < 600) ? 600 : deviceHeight;
    mainWidth = mainHeight / 2;

    titleFontSize = fontSp * 25;
    textFontSize = fontSp * 20;

    categorySize = mainWidth / 3 * 2;

    nextStepHeight = widthDp * 50;
    nextStepTextFontSize = fontSp * 17;
  }
}

class LookingForPageDesktopStyles extends LookingForPageStyles {
  LookingForPageDesktopStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 25;
    primaryVerticalPadding = widthDp * 25;

    mainHeight = (deviceHeight < 600) ? 600 : deviceHeight;
    mainWidth = mainHeight / 2;

    titleFontSize = fontSp * 25;
    textFontSize = fontSp * 20;

    categorySize = mainWidth / 3 * 2;

    nextStepHeight = widthDp * 50;
    nextStepTextFontSize = fontSp * 17;
  }
}

class LookingForPageLargeDesktopStyles extends LookingForPageStyles {
  LookingForPageLargeDesktopStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 25;
    primaryVerticalPadding = widthDp * 25;

    mainHeight = (deviceHeight < 600) ? 600 : deviceHeight;
    mainWidth = mainHeight / 2;

    titleFontSize = fontSp * 25;
    textFontSize = fontSp * 20;

    categorySize = mainWidth / 3 * 2;

    nextStepHeight = widthDp * 50;
    nextStepTextFontSize = fontSp * 17;
  }
}
