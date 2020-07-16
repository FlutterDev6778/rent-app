import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rental/Models/index.dart';

import './index.dart';

class CustomerDataProvider extends FirebaseDataProvider {
  String path = "/Customers";
  FirebaseDataProvider _firebaseProvider = FirebaseDataProvider();

  Future<CustomerModel> addCustomer({@required CustomerModel customerModel}) async {
    var result = await _firebaseProvider.addDocument(path: path, data: customerModel.toJson());
    if (result != "-1")
      return CustomerModel.fromJson(result);
    else
      return null;
  }

  Future<bool> updateCustomer({@required CustomerModel customerModel}) async {
    return await _firebaseProvider.updateDocument(path: path, id: customerModel.id, data: customerModel.toJson());
  }

  Future<bool> deleteCustomer({@required String id}) async {
    return await _firebaseProvider.deleteDocument(path: path, id: id);
  }

  Future<List<CustomerModel>> getCustomerData({List<Map<String, dynamic>> wheres, List<Map<String, dynamic>> orderby, int limit}) async {
    var result = await _firebaseProvider.getDocumentData(path: path, wheres: wheres, orderby: orderby, limit: limit);
    if (result != "-1") {
      List<CustomerModel> customerModelList = [];
      for (var i = 0; i < result.length; i++) {
        customerModelList.add(CustomerModel.fromJson(result[i]));
      }
      return customerModelList;
    } else
      return null;
  }

  Future<bool> isCustomerExist({@required String id}) async {
    return await _firebaseProvider.isDocExist(path: path, id: id);
  }

  Future<CustomerModel> getCustomerByID({@required String id}) async {
    try {
      DocumentSnapshot documentSnapshot = await Firestore.instance.collection(path).document(id).get();
      Map<String, dynamic> data = documentSnapshot.data;
      data["id"] = documentSnapshot.documentID;
      return CustomerModel.fromJson(data);
    } catch (e) {
      print("getDocumentByID Error : $e");
      return null;
    }
  }

  Stream<CustomerModel> getCustomerStreamByID({@required String id}) {
    return _firebaseProvider.getDocumentStreamByID(path: path, id: id).map((data) {
      return CustomerModel.fromJson(data);
    });
  }

  Stream<List<CustomerModel>> getCustomerStream({
    List<Map<String, dynamic>> wheres,
    List<Map<String, dynamic>> orderby,
    int limit,
  }) {
    return _firebaseProvider.getDocumentsStream(path: path, wheres: wheres, orderby: orderby, limit: limit).map((dataList) {
      return dataList.map((data) {
        return CustomerModel.fromJson(data);
      }).toList();
    });
  }

  void dispose() {
    // TODO: implement dispose
  }
}
