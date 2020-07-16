// import 'dart:async';
// import 'dart:io';
// import 'package:universal_html/html.dart' as html;
// import 'dart:math';
// import 'dart:typed_data';

// import 'package:firebase/firebase.dart' as fb;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class StorageDataProvider {
//   static Future<String> uploadFileObject({@required String path, @required String fileName, @required File file}) async {
//     try {
//       fileName = _getValidatedFileName(fileName);
//       StorageReference storageReference = FirebaseStorage.instance.ref().child("$path$fileName");
//       StorageUploadTask uploadTask = storageReference.putFile(file);
//       final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {});
//       await uploadTask.onComplete;
//       streamSubscription.cancel();
//       return await storageReference.getDownloadURL();
//     } catch (e) {
//       return "unknown";
//     }
//   }

//   static Future<dynamic> uploadHtmlFileObject({@required String path, @required html.File file}) async {
//     try {
//       String fileName = _getValidatedFileName(file.name);
//       fb.StorageReference storageRef = fb.storage().ref("$path$fileName");
//       fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(file).future;
//       Uri url = await uploadTaskSnapshot.ref.getDownloadURL();
//       return url.toString();
//     } catch (e) {
//       print(e);
//       return "unknown";
//     }
//   }

//   static Future<String> uploadByteData({@required String path, @required String fileName, @required Uint8List byteData}) async {
//     try {
//       fileName = _getValidatedFileName(fileName);
//       StorageReference storageReference = FirebaseStorage.instance.ref().child("$path$fileName");
//       StorageUploadTask uploadTask = storageReference.putData(byteData);
//       final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {});
//       await uploadTask.onComplete;
//       streamSubscription.cancel();
//       uploadTask.cancel();
//       return await storageReference.getDownloadURL();
//     } catch (e) {
//       return "unknown";
//     }
//   }

//   static String _getValidatedFileName(String fileName) {
//     var listFileName = fileName.split('.');
//     String extention = listFileName[listFileName.length - 1];
//     String fName = fileName.substring(0, fileName.length - extention.length - 2);
//     return "${fName}_${Random().nextInt(10000000).toString()}.$extention";
//   }
// }
