import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';

class LookingForCarDetail1PageStyles {
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
  double fieldSpacing;
  double fieldItemHeight;

  double slideBarHeight;

  double nextStepHeight;
  double nextStepTextFontSize;

  LookingForCarDetail1PageStyles(BuildContext context) {}
}

class LookingForCarDetail1PageMobileStyles extends LookingForCarDetail1PageStyles {
  LookingForCarDetail1PageMobileStyles(BuildContext context) : super(context) {
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
    textFontSize = fontSp * 17;
    fieldSpacing = widthDp * 20;
    fieldItemHeight = widthDp * 45;

    slideBarHeight = widthDp * 110;

    nextStepHeight = widthDp * 53.36;
    nextStepTextFontSize = fontSp * 20;
  }
}

class LookingForCarDetail1PageTabletStyles extends LookingForCarDetail1PageStyles {
  LookingForCarDetail1PageTabletStyles(BuildContext context) : super(context) {
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
    fieldSpacing = widthDp * 15;
    fieldItemHeight = widthDp * 40;

    nextStepHeight = widthDp * 50;
    nextStepTextFontSize = fontSp * 17;
  }
}

class LookingForCarDetail1PageDesktopStyles extends LookingForCarDetail1PageStyles {
  LookingForCarDetail1PageDesktopStyles(BuildContext context) : super(context) {
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
    fieldSpacing = widthDp * 15;
    fieldItemHeight = widthDp * 40;

    nextStepHeight = widthDp * 50;
    nextStepTextFontSize = fontSp * 17;
  }
}

class LookingForCarDetail1PageLargeDesktopStyles extends LookingForCarDetail1PageStyles {
  LookingForCarDetail1PageLargeDesktopStyles(BuildContext context) : super(context) {
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
    fieldSpacing = widthDp * 15;
    fieldItemHeight = widthDp * 40;

    nextStepHeight = widthDp * 50;
    nextStepTextFontSize = fontSp * 17;
  }
}
