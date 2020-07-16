import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rental/Models/index.dart';

import 'index.dart';

class UserDataProvider extends FirebaseDataProvider {
  String path = "/Users";
  FirebaseDataProvider _firebaseProvider = FirebaseDataProvider();

  Future<UserModel> addUser({@required UserModel agentModel}) async {
    var result = await _firebaseProvider.addDocument(path: path, data: agentModel.toJson());
    if (result != "-1")
      return UserModel.fromJson(result);
    else
      return null;
  }

  Future<bool> updateUser({@required String id, @required UserModel agentModel}) async {
    return await _firebaseProvider.updateDocument(path: path, id: id, data: agentModel.toJson());
  }

  Future<bool> deleteUser({@required String id}) async {
    return await _firebaseProvider.deleteDocument(path: path, id: id);
  }

  Future<List<UserModel>> getUserData({List<Map<String, dynamic>> wheres, List<Map<String, dynamic>> orderby, int limit}) async {
    var result = await _firebaseProvider.getDocumentData(path: path, wheres: wheres, orderby: orderby, limit: limit);
    if (result != "-1") {
      List<UserModel> agentModelList = [];
      for (var i = 0; i < result.length; i++) {
        agentModelList.add(UserModel.fromJson(result[i]));
      }
      return agentModelList;
    } else
      return null;
  }

  Future<bool> isUserExist({@required String id}) async {
    return await _firebaseProvider.isDocExist(path: path, id: id);
  }

  Future<UserModel> getUserByID({@required String id}) async {
    try {
      DocumentSnapshot documentSnapshot = await Firestore.instance.collection(path).document(id).get();
      Map<String, dynamic> data = documentSnapshot.data;
      data["id"] = documentSnapshot.documentID;
      return UserModel.fromJson(data);
    } catch (e) {
      print("getDocumentByID Error : $e");
      return null;
    }
  }

  Stream<UserModel> getUserStreamByID({@required String id}) {
    return _firebaseProvider.getDocumentStreamByID(path: path, id: id).map((data) {
      return UserModel.fromJson(data);
    });
  }

  Stream<List<UserModel>> getUsersStream({
    List<Map<String, dynamic>> wheres,
    List<Map<String, dynamic>> orderby,
    int limit,
  }) {
    return _firebaseProvider.getDocumentsStream(path: path, wheres: wheres, orderby: orderby, limit: limit).map((dataList) {
      return dataList.map((data) {
        return UserModel.fromJson(data);
      }).toList();
    });
  }

  void dispose() {
    // TODO: implement dispose
  }
}
