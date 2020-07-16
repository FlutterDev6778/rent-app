import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rental/Models/index.dart';

import './index.dart';

class OfferDataProvider extends FirebaseDataProvider {
  String path = "/Offers";
  FirebaseDataProvider _firebaseProvider = FirebaseDataProvider();

  Future<OfferModel> addOffer({@required OfferModel offerModel}) async {
    var result = await _firebaseProvider.addDocument(path: path, data: offerModel.toJson());
    if (result != "-1")
      return OfferModel.fromJson(result);
    else
      return null;
  }

  Future<bool> updateOffer({@required OfferModel offerModel}) async {
    return await _firebaseProvider.updateDocument(path: path, id: offerModel.id, data: offerModel.toJson());
  }

  Future<bool> deleteOffer({@required String id}) async {
    return await _firebaseProvider.deleteDocument(path: path, id: id);
  }

  Future<List<OfferModel>> getOfferData({List<Map<String, dynamic>> wheres, List<Map<String, dynamic>> orderby, int limit}) async {
    var result = await _firebaseProvider.getDocumentData(path: path, wheres: wheres, orderby: orderby, limit: limit);
    if (result != "-1") {
      List<OfferModel> offerModelList = [];
      for (var i = 0; i < result.length; i++) {
        offerModelList.add(OfferModel.fromJson(result[i]));
      }
      return offerModelList;
    } else
      return null;
  }

  Future<bool> isOfferExist({@required String id}) async {
    return await _firebaseProvider.isDocExist(path: path, id: id);
  }

  Future<OfferModel> getOfferByID({@required String id}) async {
    try {
      DocumentSnapshot documentSnapshot = await Firestore.instance.collection(path).document(id).get();
      Map<String, dynamic> data = documentSnapshot.data;
      data["id"] = documentSnapshot.documentID;
      return OfferModel.fromJson(data);
    } catch (e) {
      print("getDocumentByID Error : $e");
      return null;
    }
  }

  Stream<OfferModel> getOfferStreamByID({@required String id}) {
    return _firebaseProvider.getDocumentStreamByID(path: path, id: id).map((data) {
      return OfferModel.fromJson(data);
    });
  }

  Stream<List<OfferModel>> getOfferStream({
    List<Map<String, dynamic>> wheres,
    List<Map<String, dynamic>> orderby,
    int limit,
  }) {
    return _firebaseProvider.getDocumentsStream(path: path, wheres: wheres, orderby: orderby, limit: limit).map((dataList) {
      return dataList.map((data) {
        return OfferModel.fromJson(data);
      }).toList();
    });
  }

  void dispose() {
    // TODO: implement dispose
  }
}
