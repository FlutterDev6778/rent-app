import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './index.dart';

import 'package:rental/Pages/WelcomePage/welcome_page.dart';
import 'package:rental/Pages/LoginForAgentPage/login_for_agent_page.dart';
import 'package:rental/Pages/SignupForAgentPage/signup_for_agent_page.dart';
import 'package:rental/Pages/SignupFinalPage/signup_final_page.dart';
import 'package:rental/Pages/LookingForPage/looking_for_page.dart';
import 'package:rental/Pages/LookingForHouseDetail1Page/looking_for_house_detail1_page.dart';
import 'package:rental/Pages/LookingForHouseDetail2Page/looking_for_house_detail2_page.dart';
import 'package:rental/Pages/LookingForCarDetail1Page/looking_for_car_detail1_page.dart';
import 'package:rental/Pages/LookingForCarDetail2Page/looking_for_car_detail2_page.dart';
import 'package:rental/Pages/SendCustomerInfoPage/send_customer_info_page.dart';
import 'package:rental/Pages/AgentMainPage/agent_main_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppDataProvider(context)),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalization.of(context).delegate,
          const FallbackCupertinoLocalisationsDelegate(),
        ],
        supportedLocales: EasyLocalization.of(context).supportedLocales,
        locale: EasyLocalization.of(context).locale,
        theme: buildThemeData(),
        home: WelcomePage(),
        routes: {
          '/welcome_page': (context) => WelcomePage(),
          '/login_for_agent_page': (context) => LoginForAgentPage(),
          '/signup_for_agent_page': (context) => SignupForAgentPage(),
          '/signup_final_page': (context) => SignupFinalPage(),
          '/looking_for_page': (context) => LookingForPage(),
          '/looking_for_car_detail1_page': (context) => LookingForCarDetail1Page(),
          '/looking_for_car_detail2_page': (context) => LookingForCarDetail2Page(),
          '/looking_for_house_detail1_page': (context) => LookingForHouseDetail1Page(),
          '/looking_for_house_detail2_page': (context) => LookingForHouseDetail2Page(),
          '/send_customer_info_page': (context) => SendCustomerInfoPage(),
          '/agent_main_page': (context) => AgentMainPage(),
        },
      ),
    );
  }
}
