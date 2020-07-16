import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/DataProviders/offer_data_provider.dart';
import 'package:rental/Models/index.dart';

class AgentMainPageProvider extends ChangeNotifier {
  static AgentMainPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<AgentMainPageProvider>(context, listen: listen);

  AgentMainPageProvider(int category, AgentModel agentModel) {
    _category = category;
    _agentModel = agentModel;
  }

  int _category;
  int get category => _category;

  AgentModel _agentModel;
  AgentModel get agentModel => _agentModel;

  Stream<List<OfferModel>> _offerModelListStream;
  Stream<List<OfferModel>> get offerModelListStream => _offerModelListStream;

  Stream<List<OfferModel>> _connectedOfferModelListStream;
  Stream<List<OfferModel>> get connectedOfferModelListStream => _connectedOfferModelListStream;

  OfferDataProvider _offerDataProvider = OfferDataProvider();

  void getOfferStream() async {
    try {
      _offerModelListStream = _offerDataProvider.getOfferStream(
        wheres: [
          {"key": "category", "val": _category}
        ],
        orderby: [
          {"key": "ts", "desc": "true"}
        ],
      );
    } catch (e) {
      print("=================");
      print(e);
    }
  }

  void getConnectedOfferStream() {
    _connectedOfferModelListStream = _offerDataProvider.getOfferStream(
      wheres: [
        {"key": "category", "val": _category},
        {"key": "agentList", "cond": "arrayContains", "val": _agentModel.id}
      ],
      orderby: [
        {"key": "ts", "desc": "true"}
      ],
    );
  }
}
