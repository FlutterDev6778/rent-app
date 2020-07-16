import 'package:rental/Models/car_model.dart';
import 'package:rental/Models/house_model.dart';

class CustomerModel {
  String id;
  String name;
  String phoneNumber;
  // HouseModel houseModel;
  // CarModel carModel;
  // bool isApproved;
  String token;
  int ts;

  CustomerModel({
    id = "unknown",
    category,
    name = "",
    phoneNumber = "",
    houseModel,
    carModel,
    isApproved = false,
    token = "",
    ts,
  }) {
    this.id = id;
    this.name = name;
    this.phoneNumber = phoneNumber;
    // this.carModel = carModel;
    // this.houseModel = houseModel;
    // this.isApproved = isApproved;
    this.token = token;
    this.ts = ts ?? DateTime.now().millisecondsSinceEpoch;
  }

  CustomerModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : null,
        name = (json['name'] != null) ? json['name'] : "",
        phoneNumber = (json['phoneNumber'] != null) ? json['phoneNumber'] : "",
        // carModel = (json['carModel'] != null) ? CarModel.fromJson(json['carModel']) : null,
        // houseModel = (json['houseModel'] != null) ? HouseModel.fromJson(json['houseModel']) : null,
        // isApproved = (json['isApproved'] != null) ? json['isApproved'] : false,
        token = (json['token'] != null) ? json['token'] : "",
        ts = (json['ts'] != null) ? json['ts'] : DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      "id": (id == null) ? null : id,
      "name": (name == null) ? "" : name,
      "phoneNumber": (phoneNumber == null) ? "" : phoneNumber,
      // "carModel": (carModel == null) ? null : carModel.toJson(),
      // "houseModel": (houseModel == null) ? null : houseModel.toJson(),
      // "isApproved": (isApproved == null) ? false : isApproved,
      "token": (token == null) ? "" : token,
      "ts": (ts == null) ? DateTime.now().millisecondsSinceEpoch : ts,
    };
  }
}
