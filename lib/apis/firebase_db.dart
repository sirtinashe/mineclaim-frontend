import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/models/mine.dart';
import 'package:mineclaim/widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDB{
  FirebaseFirestore db = FirebaseFirestore.instance;
  final Future<SharedPreferences> _sharedPreferences =  SharedPreferences.getInstance() ;

  /*Mine({
    required this.mineId,
    required this.mineLocation,
    required this.area,
    required this.price,
    required this.gpsLatitude,
    required this.gpsLongitude,
    required this.timeAdded,
  });*/
  Future<bool> addMine(BuildContext context,String mineLocation, String area, String price, String gpsLatitude, String gpsLongitude) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences ;
    String? uuid  =  sharedPreferences.getString("uuid");
    DateTime timeStamp = DateTime.now();
    String doc = timeStamp.millisecondsSinceEpoch.toString()+"user"+uuid.toString();

    Mine mine =  Mine(
        mineId: timeStamp.millisecondsSinceEpoch.toString(),
        mineLocation: mineLocation,
        area: area,
        price: price,
        gpsLatitude: gpsLatitude,
        gpsLongitude: gpsLongitude,
        timeAdded: timeStamp.millisecondsSinceEpoch.toString(),
        verified: false,
        mineOwner: uuid.toString(),
        requestType: 'Verify mine',
        requestStatus: 'Pending'

    );

   final mineData =  mine.toJson() ;

    db
        .collection(uuid.toString())
        .doc(doc)
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
}