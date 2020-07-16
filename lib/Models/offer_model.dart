import 'package:rental/Models/car_model.dart';
import 'package:rental/Models/house_model.dart';

class OfferModel {
  String id;
  String customerID;
  int category;
  HouseModel houseModel;
  CarModel carModel;
  List<dynamic> agentList;
  bool isApproved;
  int ts;

  OfferModel({
    id = "unknown",
    category,
    customerID = "",
    houseModel,
    carModel,
    agentList = const [],
    isApproved = false,
    ts,
  }) {
    this.id = id;
    this.customerID = customerID;
    this.category = category;
    this.carModel = carModel;
    this.houseModel = houseModel;
    this.agentList = agentList;
    this.isApproved = isApproved;
    this.ts = ts ?? DateTime.now().millisecondsSinceEpoch;
  }

  OfferModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : null,
        customerID = (json['customerID'] != null) ? json['customerID'] : "",
        category = (json['category'] != null) ? json['category'] : null,
        carModel = (json['carModel'] != null) ? CarModel.fromJson(json['carModel']) : null,
        houseModel = (json['houseModel'] != null) ? HouseModel.fromJson(json['houseModel']) : null,
        agentList = (json['agentList'] != null) ? json['agentList'] : [],
        isApproved = (json['isApproved'] != null) ? json['isApproved'] : false,
        ts = (json['ts'] != null) ? json['ts'] : DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      "id": (id == null) ? null : id,
      "customerID": (customerID == null) ? "" : customerID,
      "category": (category == null) ? null : category,
      "carModel": (carModel == null) ? null : carModel.toJson(),
      "houseModel": (houseModel == null) ? null : houseModel.toJson(),
      "agentList": (agentList == null) ? [] : agentList,
      "isApproved": (isApproved == null) ? false : isApproved,
      "ts": (ts == null) ? DateTime.now().millisecondsSinceEpoch : ts,
    };
  }
}
