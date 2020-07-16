import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rental/Models/index.dart';

import './index.dart';

class AgentDataProvider extends FirebaseDataProvider {
  String path = "/Agents";
  FirebaseDataProvider _firebaseProvider = FirebaseDataProvider();
  OfferDataProvider _offerDataProvider = OfferDataProvider();

  Future<AgentModel> addAgent({@required AgentModel agentModel}) async {
    var result = await _firebaseProvider.addDocument(path: path, data: agentModel.toJson());
    if (result != "-1")
      return AgentModel.fromJson(result);
    else
      return null;
  }

  Future<bool> updateAgent({@required AgentModel agentModel}) async {
    return await _firebaseProvider.updateDocument(path: path, id: agentModel.id, data: agentModel.toJson());
  }

  Future<bool> deleteAgent({@required String id}) async {
    return await _firebaseProvider.deleteDocument(path: path, id: id);
  }

  Future<List<AgentModel>> getAgentData({List<Map<String, dynamic>> wheres, List<Map<String, dynamic>> orderby, int limit}) async {
    var result = await _firebaseProvider.getDocumentData(path: path, wheres: wheres, orderby: orderby, limit: limit);
    if (result != "-1") {
      List<AgentModel> agentModelList = [];
      for (var i = 0; i < result.length; i++) {
        agentModelList.add(AgentModel.fromJson(result[i]));
      }
      return agentModelList;
    } else
      return null;
  }

  Future<bool> isAgentExist({@required String id}) async {
    return await _firebaseProvider.isDocExist(path: path, id: id);
  }

  Future<AgentModel> getAgentByID({@required String id}) async {
    try {
      DocumentSnapshot documentSnapshot = await Firestore.instance.collection(path).document(id).get();
      Map<String, dynamic> data = documentSnapshot.data;
      data["id"] = documentSnapshot.documentID;
      return AgentModel.fromJson(data);
    } catch (e) {
      print("getDocumentByID Error : $e");
      return null;
    }
  }

  Stream<AgentModel> getAgentStreamByID({@required String id}) {
    return _firebaseProvider.getDocumentStreamByID(path: path, id: id).map((data) {
      return AgentModel.fromJson(data);
    });
  }

  Stream<List<AgentModel>> getAgentStream({
    List<Map<String, dynamic>> wheres,
    List<Map<String, dynamic>> orderby,
    int limit,
  }) {
    return _firebaseProvider.getDocumentsStream(path: path, wheres: wheres, orderby: orderby, limit: limit).map((dataList) {
      return dataList.map((data) {
        return AgentModel.fromJson(data);
      }).toList();
    });
  }

  void dispose() {
    // TODO: implement dispose
  }
}
