import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rental/CustomWidgets/index.dart';
import 'package:rental/DataProviders/customer_data_provider.dart';
import 'package:rental/Models/index.dart';
import 'package:rental/Pages/CarOfferDetailPage/car_offer_detail_page.dart';
import 'package:rental/Services/index.dart';

import './index.dart';

import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Models/index.dart';
import 'package:rental/Pages/Components/car_item_widget.dart';
import 'package:rental/Pages/Components/offer_with_customer_widget.dart';
import 'package:rental/Pages/Components/house_item_widget.dart';
import 'package:rental/Pages/HouseOfferDetailPage/house_offer_detail_page.dart';
import 'package:rental/DataProviders/index.dart';

class AgentMainPage extends StatelessWidget {
  AgentMainPageProvider _agentMainPageProvider;
  AgentMainPageStyles _agentMainPageStyles;
  AgentMainPage({this.category = 1, this.agentModel});

  int category;
  AgentModel agentModel;

  CustomerDataProvider _customerDataProvider = CustomerDataProvider();
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  /// 1: car 2: house

  @override
  Widget build(BuildContext context) {
    _agentMainPageStyles = AgentMainPageStyles(context);
    _firebaseNotification.init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AgentMainPageProvider(category, agentModel)),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _agentMainPageStyles = AgentMainPageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _agentMainPageStyles = AgentMainPageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _agentMainPageStyles = AgentMainPageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _agentMainPageStyles = AgentMainPageMobileStyles(context);
          }

          if (kIsWeb)
            return LayoutBuilder(
              builder: (context, constraints) {
                return _containerMain(context);
              },
            );
          else
            return LayoutBuilder(
              builder: (context, constraints) {
                return _containerMain(context);
              },
            );
        },
      ),
    );
  }

  Widget _containerMain(BuildContext context) {
    print("__________ AgentMainPage _____________");
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Text(
                    AgentMainPageString.exitAppbarIconText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: _agentMainPageStyles.titleFontSize, color: Colors.white),
                  ),
                ),
              ],
            ),
            title: Center(
              child: Text(
                AgentMainPageString.appbarText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: _agentMainPageStyles.titleFontSize, color: Colors.black),
              ),
            ),
            actions: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: _agentMainPageStyles.primaryHorizontalPadding),
                      child: Text(
                        AgentMainPageString.exitAppbarIconText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: _agentMainPageStyles.titleFontSize, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    AgentMainPageString.tab1Text,
                    style: TextStyle(fontSize: _agentMainPageStyles.textFontSize, color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    AgentMainPageString.tab2Text,
                    style: TextStyle(fontSize: _agentMainPageStyles.textFontSize, color: Colors.black),
                  ),
                ),
              ],
              indicatorWeight: 5,
              indicatorColor: AgentMainPageColors.primaryColor,
            ),
          ),
          body: Container(
            width: _agentMainPageStyles.deviceWidth,
            color: (_agentMainPageStyles.runtimeType == AgentMainPageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: Container(
              width: _agentMainPageStyles.mainWidth,
              alignment: Alignment.topCenter,
              color: Colors.white,
              child: TabBarView(
                children: <Widget>[
                  _containerTabViewForCustomers(context),
                  _containerTabViewForOffers(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerTabViewForOffers(BuildContext context) {
    AgentMainPageProvider.of(context).getConnectedOfferStream();
    return Consumer<AgentMainPageProvider>(
      builder: (context, agentMainPageProvider, _) {
        return Container(
          width: _agentMainPageStyles.mainWidth,
          child: StreamBuilder<List<OfferModel>>(
            stream: agentMainPageProvider.connectedOfferModelListStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CustomCupertinoIndicator(
                    brightness: Brightness.light,
                  ),
                );
              }
              if (snapshot.data.length == 0)
                return Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(fontSize: _agentMainPageStyles.textFontSize),
                  ),
                );
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  OfferModel _offerModel = snapshot.data[index];
                  return StreamBuilder<CustomerModel>(
                    stream: _customerDataProvider.getCustomerStreamByID(id: _offerModel.customerID),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: _agentMainPageStyles.widthDp * 10),
                          child: Center(
                            child: CustomCupertinoIndicator(brightness: Brightness.light),
                          ),
                        );
                      }

                      return (_offerModel.category == 2)
                          ? InkWell(
                              child: HouseItemWidget(
                                width: _agentMainPageStyles.mainWidth - _agentMainPageStyles.primaryHorizontalPadding * 2,
                                offerModel: _offerModel,
                                titleFontSize: _agentMainPageStyles.listItemTitelFontSize,
                                textFontSize: _agentMainPageStyles.listItemTextFontSize,
                                itemSpacing: _agentMainPageStyles.listItemSpacing,
                                horizontalPadding: _agentMainPageStyles.listItemHorizontalPadding,
                                verticalPadding: _agentMainPageStyles.listItemVerticalPadding,
                              ),
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => HouseOfferDetailPage(
                                      offerModel: _offerModel,
                                      customerModel: snapshot.data,
                                      agentModel: agentModel,
                                      isConnected: true,
                                    ),
                                  ),
                                );
                                _firebaseNotification.init(context);
                              },
                            )
                          : InkWell(
                              child: CarItemWidget(
                                width: _agentMainPageStyles.mainWidth - _agentMainPageStyles.primaryHorizontalPadding * 2,
                                offerModel: _offerModel,
                                titleFontSize: _agentMainPageStyles.listItemTitelFontSize,
                                textFontSize: _agentMainPageStyles.listItemTextFontSize,
                                itemSpacing: _agentMainPageStyles.listItemSpacing,
                                horizontalPadding: _agentMainPageStyles.listItemHorizontalPadding,
                                verticalPadding: _agentMainPageStyles.listItemVerticalPadding,
                              ),
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => CarOfferDetailPage(
                                      offerModel: _offerModel,
                                      customerModel: snapshot.data,
                                      agentModel: agentModel,
                                      isConnected: true,
                                    ),
                                  ),
                                );
                                _firebaseNotification.init(context);
                              },
                            );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _containerTabViewForCustomers(BuildContext context) {
    AgentMainPageProvider.of(context).getOfferStream();
    return Consumer<AgentMainPageProvider>(
      builder: (context, agentMainPageProvider, _) {
        return Container(
          width: _agentMainPageStyles.mainWidth,
          child: StreamBuilder<List<OfferModel>>(
            stream: agentMainPageProvider.offerModelListStream,
            builder: (context, snapshot) {
              print("---------------------------");
              if (!snapshot.hasData) {
                return Center(
                  child: CustomCupertinoIndicator(
                    brightness: Brightness.light,
                  ),
                );
              }
              print("-----------22222222222222----------------");
              if (snapshot.data.length == 0)
                return Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(fontSize: _agentMainPageStyles.textFontSize),
                  ),
                );
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  OfferModel _offerModel = snapshot.data[index];

                  return StreamBuilder<CustomerModel>(
                      stream: _customerDataProvider.getCustomerStreamByID(id: _offerModel.customerID),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: _agentMainPageStyles.widthDp * 10),
                            child: Center(
                              child: CustomCupertinoIndicator(brightness: Brightness.light),
                            ),
                          );
                        }
                        return InkWell(
                          child: OfferWithCustomerWidget(
                            width: _agentMainPageStyles.mainWidth - _agentMainPageStyles.primaryHorizontalPadding * 2,
                            offerModel: _offerModel,
                            customerModel: snapshot.data,
                            category: category,
                            titleFontSize: _agentMainPageStyles.listItemTitelFontSize,
                            textFontSize: _agentMainPageStyles.listItemTextFontSize,
                            itemSpacing: _agentMainPageStyles.listItemSpacing,
                            horizontalPadding: _agentMainPageStyles.listItemHorizontalPadding,
                            verticalPadding: _agentMainPageStyles.listItemVerticalPadding,
                          ),
                          onTap: () async {
                            if (category == 2) {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HouseOfferDetailPage(
                                    offerModel: _offerModel,
                                    agentModel: agentModel,
                                    customerModel: snapshot.data,
                                    isConnected: (_offerModel.agentList.contains(agentModel.id)),
                                  ),
                                ),
                              );
                            } else {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => CarOfferDetailPage(
                                    offerModel: _offerModel,
                                    agentModel: agentModel,
                                    customerModel: snapshot.data,
                                    isConnected: (_offerModel.agentList.contains(agentModel.id)),
                                  ),
                                ),
                              );
                            }
                            _firebaseNotification.init(context);
                          },
                        );
                      });
                },
              );
            },
          ),
        );
      },
    );
  }
}
