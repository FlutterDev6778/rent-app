import 'package:rental/Constants/constants.dart';

class HouseModel {
  String id;
  String city;
  int priceFrom;
  int priceTo;
  int roomsFrom;
  int roomsTo;
  String propertyType;
  int sizeFrom;
  int sizeTo;
  bool isRenovated;
  bool haveParkingLot;
  bool haveYard;
  bool havePets;
  String notes;
  int ts;

  HouseModel({
    id = "unknown",
    city = "",
    priceFrom,
    priceTo,
    roomsFrom,
    roomsTo,
    propertyType = "",
    sizeFrom,
    sizeTo,
    isRenovated = false,
    haveParkingLot = false,
    haveYard = false,
    havePets = false,
    notes = "",
    ts,
  }) {
    this.id = id;
    this.city = city;
    this.priceFrom = priceFrom ?? Constants.priceFrom;
    this.priceTo = priceTo ?? Constants.priceTo;
    this.roomsFrom = roomsFrom ?? Constants.roomsFrom;
    this.roomsTo = roomsTo ?? Constants.roomsTo;
    this.propertyType = propertyType;
    this.sizeFrom = sizeFrom ?? Constants.sizeFrom;
    this.sizeTo = sizeTo ?? Constants.sizeTo;
    this.isRenovated = isRenovated;
    this.haveParkingLot = haveParkingLot;
    this.haveYard = haveYard;
    this.havePets = havePets;
    this.notes = notes;
    this.ts = ts ?? DateTime.now().millisecondsSinceEpoch;
  }

  HouseModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : null,
        city = (json['city'] != null) ? json['city'] : "",
        priceFrom = (json['priceFrom'] != null) ? int.parse(json['priceFrom'].toString()) : Constants.priceFrom,
        priceTo = (json['priceTo'] != null) ? int.parse(json['priceTo'].toString()) : Constants.priceTo,
        roomsFrom = (json['roomsFrom'] != null) ? int.parse(json['roomsFrom'].toString()) : Constants.roomsFrom,
        roomsTo = (json['roomsTo'] != null) ? int.parse(json['roomsTo'].toString()) : Constants.roomsTo,
        propertyType = (json['propertyType'] != null) ? json['propertyType'] : "",
        sizeFrom = (json['sizeFrom'] != null) ? int.parse(json['sizeFrom'].toString()) : Constants.sizeFrom,
        sizeTo = (json['sizeTo'] != null) ? int.parse(json['sizeTo'].toString()) : Constants.sizeTo,
        isRenovated = (json['isRenovated'] != null) ? json['isRenovated'] : false,
        haveParkingLot = (json['haveParkingLot'] != null) ? json['haveParkingLot'] : false,
        haveYard = (json['haveYard'] != null) ? json['haveYard'] : false,
        havePets = (json['havePets'] != null) ? json['havePets'] : false,
        notes = (json['notes'] != null) ? json['notes'] : "",
        ts = (json['ts'] != null) ? json['ts'] : DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    return {
      "id": (id == null) ? null : id,
      "city": (city == null) ? "" : city,
      "priceFrom": (priceFrom == null) ? Constants.priceFrom : int.parse(priceFrom.toString()),
      "priceTo": (priceTo == null) ? Constants.priceTo : int.parse(priceTo.toString()),
      "roomsFrom": (roomsFrom == null) ? Constants.roomsFrom : int.parse(roomsFrom.toString()),
      "roomsTo": (roomsTo == null) ? Constants.roomsTo : int.parse(roomsTo.toString()),
      "propertyType": (propertyType == null) ? "" : propertyType,
      "sizeFrom": (sizeFrom == null) ? Constants.sizeFrom : int.parse(sizeFrom.toString()),
      "sizeTo": (sizeTo == null) ? Constants.sizeTo : int.parse(sizeTo.toString()),
      "isRenovated": (isRenovated == null) ? false : isRenovated,
      "haveParkingLot": (haveParkingLot == null) ? false : haveParkingLot,
      "haveYard": (haveYard == null) ? false : haveYard,
      "havePets": (havePets == null) ? false : havePets,
      "notes": (notes == null) ? "" : notes,
      "ts": (ts == null) ? DateTime.now().millisecondsSinceEpoch : ts,
    };
  }
}
