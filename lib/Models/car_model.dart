import 'package:rental/Constants/constants.dart';

class CarModel {
  String id;
  List<dynamic> producerList;
  List<dynamic> modelList;
  int kilometer;
  int yearFrom;
  int yearTo;
  int priceFrom;
  int priceTo;
  int handFrom;
  int handTo;
  String color;
  bool haveGear;
  bool haveAuto;
  String notes;
  int ts;

  CarModel({
    id = "unknown",
    producerList,
    modelList,
    kilometer,
    yearFrom,
    yearTo,
    priceFrom,
    priceTo,
    handFrom,
    handTo,
    color = "",
    haveGear = false,
    haveAuto = false,
    notes = "",
    ts,
  }) {
    this.id = id;
    this.producerList = (producerList != null) ? producerList : [];
    this.modelList = (modelList != null) ? modelList : [];
    this.kilometer = kilometer ?? Constants.kilometerTo ~/ 2;
    this.yearFrom = yearFrom ?? Constants.yearFrom;
    this.yearTo = yearTo ?? Constants.yearTo;
    this.priceFrom = priceFrom ?? Constants.priceFrom;
    this.priceTo = priceTo ?? Constants.priceTo;
    this.handFrom = handFrom ?? Constants.handFrom;
    this.handTo = handTo ?? Constants.handTo;
    this.color = color;
    this.haveGear = haveGear;
    this.haveAuto = haveAuto;
    this.notes = notes;
    this.ts = ts ?? DateTime.now().millisecondsSinceEpoch;
  }

  CarModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : null,
        producerList = (json['producerList'] != null) ? json['producerList'] : [],
        modelList = (json['modelList'] != null) ? json['modelList'] : [],
        kilometer = (json['kilometer'] != null) ? int.parse(json['kilometer'].toString()) : int.parse((Constants.kilometerTo / 2).toString()),
        yearFrom = (json['yearFrom'] != null) ? int.parse(json['yearFrom'].toString()) : Constants.yearFrom,
        yearTo = (json['yearTo'] != null) ? int.parse(json['yearTo'].toString()) : Constants.yearTo,
        priceFrom = (json['priceFrom'] != null) ? int.parse(json['priceFrom'].toString()) : Constants.priceFrom,
        priceTo = (json['priceTo'] != null) ? int.parse(json['priceTo'].toString()) : Constants.priceTo,
        handFrom = (json['handFrom'] != null) ? int.parse(json['handFrom'].toString()) : Constants.handFrom,
        handTo = (json['handTo'] != null) ? int.parse(json['handTo'].toString()) : Constants.handTo,
        color = (json['color'] != null) ? json['color'] : "",
        haveGear = (json['haveGear'] != null) ? json['haveGear'] : false,
        haveAuto = (json['haveAuto'] != null) ? json['haveAuto'] : false,
        notes = (json['notes'] != null) ? json['notes'] : "",
        ts = (json['ts'] != null) ? json['ts'] : DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      "id": (id == null) ? null : id,
      "producerList": (producerList == null) ? [] : producerList,
      "modelList": (modelList == null) ? [] : modelList,
      "kilometer": (kilometer == null) ? int.parse((Constants.kilometerTo / 2).toString()) : int.parse(kilometer.toString()),
      "yearFrom": (yearFrom == null) ? Constants.yearFrom : int.parse(yearFrom.toString()),
      "yearTo": (yearTo == null) ? Constants.yearTo : int.parse(yearTo.toString()),
      "priceFrom": (priceFrom == null) ? Constants.priceFrom : int.parse(priceFrom.toString()),
      "priceTo": (priceTo == null) ? Constants.priceTo : int.parse(priceTo.toString()),
      "handFrom": (handFrom == null) ? Constants.handFrom : int.parse(handFrom.toString()),
      "handTo": (handTo == null) ? Constants.handTo : int.parse(handTo.toString()),
      "color": (color == null) ? "" : color,
      "haveGear": (haveGear == null) ? false : haveGear,
      "haveAuto": (haveAuto == null) ? false : haveAuto,
      "notes": (notes == null) ? "" : notes,
      "ts": (ts == null) ? DateTime.now().millisecondsSinceEpoch : ts,
    };
  }
}
