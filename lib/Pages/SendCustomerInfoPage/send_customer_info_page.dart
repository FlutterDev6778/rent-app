import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart' as EL;
import 'package:rental/CustomWidgets/custom_progress_dialog.dart';
import 'package:rental/DataProviders/customer_data_provider.dart';
import 'package:rental/DataProviders/offer_data_provider.dart';
import 'package:rental/Models/index.dart';
import 'package:rental/Pages/App/Providers/index.dart';
import 'package:rental/Pages/App/Styles/index.dart';
import 'package:rental/Services/index.dart';

import './index.dart';
import 'package:rental/Pages/App/Styles/resposible_settings.dart';
import 'package:rental/Constants/constants.dart';
import 'package:rental/CustomWidgets/custom_raised_button.dart';
import 'package:rental/CustomWidgets/custom_checkbox.dart';
import 'package:rental/CustomWidgets/custom_text_form_field.dart';
import 'package:rental/Models/agent_model.dart';
import 'package:rental/Pages/LoginForAgentPage/login_for_agent_page.dart';

class SendCustomerInfoPage extends StatelessWidget {
  SendCustomerInfoPageStyles _sendCustomerInfoPageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CustomerModel _customerModel = CustomerModel();
  CarModel _carModel;
  HouseModel _houseModel;
  FirebaseNotification _firebaseNotification = FirebaseNotification();

  CustomerDataProvider _customerDataProvider = CustomerDataProvider();
  OfferDataProvider _offerDataProvider = OfferDataProvider();

  @override
  Widget build(BuildContext context) {
    _sendCustomerInfoPageStyles = SendCustomerInfoPageStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SendCustomerInfoPageProvider()),
      ],
      child: Builder(
        builder: (context) {
          if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.desktopDesignWidth)
          ////  Large desktop as like TV
          {
            _sendCustomerInfoPageStyles = SendCustomerInfoPageLargeDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.tableteMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.desktopDesignWidth)
          ////  desktop
          {
            _sendCustomerInfoPageStyles = SendCustomerInfoPageDesktopStyles(context);
          } else if (MediaQuery.of(context).size.width >= ResponsibleDesignSettings.mobileMaxWidth &&
              MediaQuery.of(context).size.width < ResponsibleDesignSettings.tableteMaxWidth)
          ////  tablet
          {
            _sendCustomerInfoPageStyles = SendCustomerInfoPageTabletStyles(context);
          } else if (MediaQuery.of(context).size.width < ResponsibleDesignSettings.mobileMaxWidth)
          ////  Mobile
          {
            _sendCustomerInfoPageStyles = SendCustomerInfoPageMobileStyles(context);
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
    print("___________ LookingForCarDetail2Page ____________");
    Map<String, dynamic> params = ModalRoute.of(context).settings.arguments;
    _carModel = params["carModel"] ?? null;
    _houseModel = params["houseModel"] ?? null;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: _sendCustomerInfoPageStyles.deviceWidth,
            color: (_sendCustomerInfoPageStyles.runtimeType == SendCustomerInfoPageMobileStyles) ? Colors.white : Colors.grey[200],
            alignment: Alignment.topCenter,
            child: _containerBody(context),
          ),
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context) {
    return Container(
      width: _sendCustomerInfoPageStyles.mainWidth,
      height: _sendCustomerInfoPageStyles.mainHeight,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: _sendCustomerInfoPageStyles.primaryHorizontalPadding,
        vertical: _sendCustomerInfoPageStyles.primaryVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _sendCustomerInfoPageStyles.primaryHorizontalPadding),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    SendCustomerInfoPageString.titleText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: _sendCustomerInfoPageStyles.titleFontSize),
                  ),
                  _containerForm(context),
                  Text(
                    SendCustomerInfoPageString.descriptionLabel,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: _sendCustomerInfoPageStyles.textFontSize),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: _sendCustomerInfoPageStyles.primaryVerticalPadding * 8),
          _containerSendButton(context),
        ],
      ),
    );
  }

  Widget _containerForm(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// --- full name
            CustomTextFormField(
              width: double.infinity,
              label: SendCustomerInfoPageString.nameLabel,
              labelFontSize: _sendCustomerInfoPageStyles.textFontSize,
              labelSpacing: _sendCustomerInfoPageStyles.widthDp * 5,
              height: _sendCustomerInfoPageStyles.fieldItemHeight,
              textFontSize: _sendCustomerInfoPageStyles.textFontSize,
              border: Border.all(width: 1, color: Colors.black),
              errorBorder: Border.all(width: 1, color: Colors.red),
              borderRadius: 4,
              hintText: SendCustomerInfoPageString.nameHintText,
              fixedHeightState: true,
              keyboardType: TextInputType.emailAddress,
              validatorHandler: (input) => (input.length < 3) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "3"}) : null,
              onChangeHandler: (input) => _customerModel.name = input.trim(),
              onSaveHandler: (input) => _customerModel.name = input.trim(),
            ),
            SizedBox(height: _sendCustomerInfoPageStyles.fieldSpacing / 2),

            /// --- phone
            CustomTextFormField(
              width: double.infinity,
              height: _sendCustomerInfoPageStyles.fieldItemHeight,
              label: SendCustomerInfoPageString.phoneLabel,
              labelFontSize: _sendCustomerInfoPageStyles.textFontSize,
              labelSpacing: _sendCustomerInfoPageStyles.widthDp * 5,
              textFontSize: _sendCustomerInfoPageStyles.textFontSize,
              border: Border.all(width: 1, color: Colors.black),
              errorBorder: Border.all(width: 1, color: Colors.red),
              borderRadius: 4,
              hintText: SendCustomerInfoPageString.phoneHintText,
              fixedHeightState: true,
              keyboardType: TextInputType.number,
              validatorHandler: (input) => (input.length < 8) ? ValidateErrorString.textlengthErrorText.tr(namedArgs: {"length": "8"}) : null,
              onChangeHandler: (input) => _customerModel.phoneNumber = input.trim(),
              onSaveHandler: (input) => _customerModel.phoneNumber = input.trim(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerSendButton(BuildContext context) {
    return Consumer<SendCustomerInfoPageProvider>(
      builder: (context, sendCustomerInfoPageProvider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRaisedButton(
              width: double.infinity,
              height: _sendCustomerInfoPageStyles.signupButtonHeight,
              color: SendCustomerInfoPageColors.primaryColor,
              borderColor: Colors.white,
              borderRadius: 10,
              child: Text(
                SendCustomerInfoPageString.sendButtonText,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: _sendCustomerInfoPageStyles.signupButtonTextFontSize, color: Colors.white),
              ),
              onPressed: () {
                send(context, sendCustomerInfoPageProvider);
              },
            ),
            SizedBox(height: _sendCustomerInfoPageStyles.widthDp * 5),
            Text(
              sendCustomerInfoPageProvider.errorString,
              style: TextStyle(fontSize: _sendCustomerInfoPageStyles.textFontSize * 0.8, color: Colors.red),
            ),
          ],
        );
      },
    );
  }

  void send(BuildContext context, SendCustomerInfoPageProvider sendCustomerInfoPageProvider) async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    await CustomProgressDialog.of(context: context).show();
    bool sendResult = false;
    CustomerModel _newCustomerModel = await _getCustomerModel(context, _customerModel);
    if (_newCustomerModel != null) {
      OfferModel _offerModel = OfferModel();
      _offerModel.customerID = _newCustomerModel.id;
      _offerModel.category = (_carModel != null) ? 1 : 2;
      _offerModel.carModel = _carModel;
      _offerModel.houseModel = _houseModel;

      var result = await _offerDataProvider.addOffer(offerModel: _offerModel);
      if (result != null) {
        sendResult = true;
      }
    }

    await CustomProgressDialog.of(context: context).hide();
    if (sendResult) Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed("/looking_for_page");
  }

  Future<CustomerModel> _getCustomerModel(BuildContext context, CustomerModel customerModel) async {
    CustomerModel _newCustomerModel;
    var result = await _customerDataProvider.getCustomerData(wheres: [
      {"key": "name", "val": customerModel.name},
      {"key": "phoneNumber", "val": customerModel.phoneNumber},
    ]);
    var newToken = await _firebaseNotification.getToken();
    if (result != null && result.length == 0) {
      customerModel.token = newToken;
      _newCustomerModel = await _customerDataProvider.addCustomer(customerModel: customerModel);
    } else if (result != null && result.length != 0) {
      _newCustomerModel = result[0];
      if (_newCustomerModel.token != newToken) {
        _newCustomerModel.token = newToken;
        var result = await _customerDataProvider.updateCustomer(customerModel: _newCustomerModel);
        if (!result) {
          _newCustomerModel = null;
        }
      }
    }

    return _newCustomerModel;
  }
}
