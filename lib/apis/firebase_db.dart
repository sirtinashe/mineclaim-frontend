import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/models/mine.dart';
import 'package:mineclaim/widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDB{
  FirebaseFirestore db = FirebaseFirestore.instance;
  final Future<SharedPreferences> _sharedPreferences =  SharedPreferences.getInstance() ;
  final storageRef = FirebaseStorage.instanceFor(bucket: 'gs://intellixbot-jqcj.appspot.com');

  /*Mine({
    required this.mineId,
    required this.mineLocation,
    required this.area,
    required this.price,
    required this.gpsLatitude,
    required this.gpsLongitude,
    required this.timeAdded,
  });*/

  Future<bool> verifyMine(BuildContext context, String mineId) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences ;
    String? uuid  =  sharedPreferences.getString("uuid");

    db
        .collection('mines')
        .doc(mineId)
        .update({
      'verified': true,
      'requestStatus': 'Verified',
      'verifiedBy': uuid.toString()
    })
        .then((value) {
      dismissDialog(context);
      showInformativeDialog("Success", Colors.green, "Mine verified successfully", context);
      return true;
    })
        .onError((e, _) {
      dismissDialog(context);
      showInformativeDialog("Error", Colors.black54, e.toString(), context);
      return false ;
    });

    return true ;
  }


  Future<bool> addMine(BuildContext context,String mineLocation, String area, String gpsLatitude, String gpsLongitude,String claimant,String documentUrl) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences ;
    String? uuid  =  sharedPreferences.getString("uuid");
    DateTime timeStamp = DateTime.now();
    String doc = timeStamp.second.toString()+"user"+uuid.toString();
    String mineId = (timeStamp.millisecondsSinceEpoch ~/ 1000).toString();

    Mine mine =  Mine(
        mineId: mineId,
        mineLocation: mineLocation,
        area: area,
        gpsLatitude: gpsLatitude,
        gpsLongitude: gpsLongitude,
        timeAdded: mineId,
        verified: false,
        mineOwner: uuid.toString(),
        requestType: 'Verify mine',
        requestStatus: 'Pending',
        claimant: claimant,
        documentUrl: documentUrl

    );

   final mineData =  mine.toJson() ;

    db
        .collection('mines')
        .doc(mineId)
        .set(mineData)
        .then((value) {
            dismissDialog(context);
            showInformativeDialog("Success", Colors.green, "Mine added successfully", context);
            return true;
            }
          )
        .onError((e, _) {
          dismissDialog(context);
          showInformativeDialog("Error", Colors.black54, e.toString(), context);
          return false ;
    });

    return true ;
  }

  Future<Map<String,dynamic>> uploadFile(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      print('File name: ${file.path}');
      // Directory appDocDir = await getApplicationDocumentsDirectory();
      Reference reference = storageRef.ref().child('demo.png');
      await reference.putFile(file);

      return {
        'success': true,
        'message': 'File uploaded successfully.',
        'data': await reference.getDownloadURL()
      };
      // uploadTask.snapshot.state == TaskState.success ? debugPrint('File uploaded successfully.') : debugPrint('File upload failed.');
      // TaskSnapshot taskSnapshot = await uploadTask;

      // if (taskSnapshot.state == TaskState.success) {
      //   String downloadUrl = await reference.getDownloadURL();
      //   debugPrint('File uploaded successfully. Download URL: $downloadUrl');
      // } else {
      //   debugPrint('File upload failed.');
      // }
    } on FirebaseException catch (e) {
      debugPrint('File upload failed. Error: $e');
      return {
        'status': false,
        'message': 'File upload failed. Error: $e',
        'data': null
      };

    }
  }
}