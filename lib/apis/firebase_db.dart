import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/globals.dart';
import 'package:mineclaim/models/mine.dart';
import 'package:mineclaim/widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart' as path;

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

  bool deleteMine(BuildContext context, String mineId){
    db
        .collection('claimed_by_$globalUuid')
        .doc(mineId)
        .delete()
        .then((value) {
      dismissDialog(context);
      // showInformativeDialog("Success", Colors.green, "Mine deleted successfully", context);
      return true;
    })
        .onError((e, _) {
      dismissDialog(context);
      // showInformativeDialog("Error", Colors.black54, e.toString(), context);
      return false ;
    });

    return true ;
  }

  Future<bool> checkMineExistence(mineId) async {
    final snapshot = await db.collection('claimed_by_$globalUuid').doc(mineId).get();
    return snapshot.exists;
  }
  // Future<bool> isMineExist(String mineId) async {
  //   db
  //       .collection('claimed_by_$globalUuid')
  //       .doc(mineId)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       print('Document data: ${documentSnapshot.data()}');
  //       return true;
  //     } else {
  //       print('Document does not exist on the database');
  //       return false;
  //     }
  //   }).onError((error, stackTrace) {
  //     print('Failed with error $error');
  //     return false;
  //   });
  //   print("No data found");
  //   return false;
  // }
  Future<bool> verifyMineTransfer(BuildContext context, String mineId) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences ;
    String? uuid  =  sharedPreferences.getString("uuid");

    db
        .collection('mineTransfers')
        .doc(mineId)
        .update({
      'verified': true,
      'requestStatus': 'Verified',
      'verifiedBy': uuid.toString()
    })
        .then((value) async {
       dismissDialog(context);
      showInformativeDialog("Success", Colors.green, "Mine transfer verified successfully", context);
      return true;
    })
        .onError((e, _) async {
      dismissDialog(context);
      showInformativeDialog("Error", Colors.black54, e.toString(), context);
      return false ;
    });
    // await dismissDialog(context);
    return true ;
  }


  Future<bool> transferMine(BuildContext context, String mineId, String newOwner) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences ;
    String? uuid  =  sharedPreferences.getString("uuid");
    // showProcessingDialog(context);
    var data = {
      'newMineOwner': newOwner,
      'requestStatus': 'Verified',
      'mineId': mineId,
      'requestType': 'TRANSFER_MINE',
      'transferredBy': uuid.toString(),
      'verified': true

    };

    db
        .collection('mineTransfers')
        .doc(mineId)
        .set(data)
        .then((value) async {
      dismissDialog(context);
      print("Request submitted. You will be notified once the verification is over.");
      showInformativeDialog("Success", Colors.green, "Request submitted. You will be notified once the verification is over.", context);
      return true;
    })
        .onError((e, _) async {
      dismissDialog(context);
      // showInformativeDialog("Error", Colors.black54, e.toString(), context);
      return false ;
    });
    // await dismissDialog(context);
    return true ;
  }

  Future<bool> transferMineV2(BuildContext context, String mineId, String newOwner) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences ;
    String? uuid  =  sharedPreferences.getString("uuid");

    db
        .collection('mines')
        .doc(mineId)
        .update({
      'mineOwner': newOwner,
      'requestStatus': 'Transferred',
      'transferredBy': uuid.toString()
    })
        .then((value) {
      dismissDialog(context);
      showInformativeDialog("Success", Colors.green, "Mine transferred successfully", context);
      return true;
    })
        .onError((e, _) {
      dismissDialog(context);
      showInformativeDialog("Error", Colors.black54, e.toString(), context);
      return false ;
    });

    return true ;
  }
  Future<bool> verifyMine(BuildContext context, String mineId) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences ;
    String? uuid  =  sharedPreferences.getString("uuid");

    db
        .collection('mines')
        .doc(mineId)
        .update({
      'verified': "Verified",
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

  bool addClaimedMines(BuildContext context , Mine mine){
    final mineData =  mine.toJson();

    db
        .collection('claimed_by_$globalUuid')
        .doc(mine.mineId)
        .set(mineData)
        .then((value) {
      // dismissDialog(context);
      showInformativeDialog("Success", Colors.green, "Mine successfully claimed", context);
      return true;
    }
    )
        .onError((e, _) {
      dismissDialog(context);
      showInformativeDialog("Error", Colors.black54, e.toString(), context);
      return false ;
    });
    dismissDialog(context);

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
        verified: "Not Verified",
        mineOwner: uuid.toString(),
        requestType: 'VERIFY_MINE',
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
            showInformativeDialog("Success", Colors.green, "Mine added successfully ,mine id is $mineId", context);
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
      // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      print('File name: ${file.path}');
      String fileName = path.basename(file.path);
      print('File name: $fileName');

      // Directory appDocDir = await getApplicationDocumentsDirectory();
      Reference reference = storageRef.ref().child(fileName);
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