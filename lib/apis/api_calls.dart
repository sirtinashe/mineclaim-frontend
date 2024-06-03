import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mineclaim/apis/urls.dart';
import 'package:mineclaim/models/mine.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/dialogs.dart';


class MineclaimApi {
  late BuildContext context;
  MineclaimApi(BuildContext ctx) {
    this.context = ctx;
  }
  String method = "";

  httpsRequest(payload, apiUrl, method) async {
    var client = http.Client();
    final http.Response response;

    // showProcessingDialog(context);

    try {
      switch (method) {
        case "POST":
          if (kDebugMode) {
            print("Method Post");
          }
          response = await client
              .post(Uri.parse(apiUrl),
              headers: <String, String>{
                // "Authorization": "Bearer ${globals.jwToken}",
                'Content-Type': 'application/json',
              },
              body: payload)
              .timeout(const Duration(seconds: 60)
          );
          if (kDebugMode) {
            // print("Post response: ${response.body}");
          }
          break;
        case "GET":
          response = await client.get(
            Uri.parse(apiUrl),
            headers: <String, String>{
              // "Authorization": "Bearer ${globals.jwToken}",
              'Content-Type': 'application/json',
            },
          ).timeout(const Duration(seconds: 60));
          if (kDebugMode) {
            print(response.body);
          }
          break;
        case "PUT":
          response = await client.put(
            Uri.parse(apiUrl),
            headers: <String, String>{
              // "Authorization": "Bearer ${globals.jwToken}",
              'Content-Type': 'application/json',
            },
          ).timeout(const Duration(seconds: 60));
          if (kDebugMode) {
            print(response.body);
          }
          break;
        default:
          throw Exception("Invalid method");
      }

      // Handle the response status code in a single place
      if (response.statusCode == 200 || response.statusCode == 201) {
        // await dismissDialog(context);
        return jsonDecode(response.body);
      } else {

        print("RESPONSE: ${response.body}");
        showInformativeDialog("Message", Colors.black54,
            jsonDecode(response.body)['message'], context);
        return {
          "success": false,
          "message": "An error occurred",
          "data": []

        };
      }
    } on FormatException catch (e) {
      // await dismissDialog(context);
      showInformativeDialog('Error', Colors.red,
          "Sorry, server info error. Try again later!", context);
      return {
        "success": false,
        "message": "Format error occurred",
        "data": []

      };
    } on SocketException catch (e) {

      // await dismissDialog(context);
      showInformativeDialog('Error', Colors.red,
          "There is a problem with the network connection!", context);
      return {
        "success": false,
        "message": "Network error occurred",
      };
    } on Exception catch (_, e) {
      // await dismissDialog(context);
      showInformativeDialog(
          'Error', Colors.red, "An unknown error occurred!", context);
      return {
        "success": false,
        "message": "Unknown error occurred",
        "data": []
      };
    } finally {

      client.close();
    }
  }
 Future transferMine( String mineId,String newOwner, String claimantName) async{
    String apiUrl = "${Urls.BASE_URL}/transfer_ownership";

    String method = "POST";
    var payload = {
      "mineId": mineId,
      "newOwnerId":newOwner,
      "claimantName": claimantName,
    };

    return await httpsRequest(jsonEncode(payload), apiUrl, method);

 }

  Future addMine(BuildContext context ,String address,String area,String gpsLatitude, String gpsLongitude,String claimant,String docUrl, String walletAddress) async {

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
    String? uuid  =  sharedPreferences.getString("uuid");
    DateTime timeStamp = DateTime.now();
    String doc = timeStamp.second.toString()+"user"+uuid.toString();
    String mineId = (timeStamp.millisecondsSinceEpoch ~/ 1000).toString();
    Mine mine =  Mine(
        mineId: mineId,
        mineLocation: address,
        area: area,
        gpsLatitude: gpsLatitude,
        gpsLongitude: gpsLongitude,
        timeAdded: mineId,
        verified: "Verified",
        mineOwner: walletAddress,
        requestType: 'VERIFY_MINE',
        requestStatus: "Verified",
        claimant: claimant,
        documentUrl: docUrl

    );

    var payload = {
      "data": mine.toJson()
    };
    String apiUrl = "${Urls.BASE_URL}/addnewmine";
    String method = "POST";
    print(jsonEncode(payload));
    return await httpsRequest(jsonEncode(payload), apiUrl, method);
  }
  getMines(String mineOwner) async {
    String apiUrl = "${Urls.BASE_URL}/mineByOwner";
    String method = "POST";
    var payload = {
      "ownerId": mineOwner,
    };
    print("From getMines $mineOwner");
    final minesJson =  await httpsRequest(jsonEncode(payload), apiUrl, method);

    print("Json response: $minesJson");
    if (minesJson['success']) {
      List<Mine> mines = [] ;
      for (var mine in minesJson['data']) {
        mines.add(Mine.fromJson(mine));
      }
      // Mine mine = Mine.fromJson(minesJson);
      // mines.add(mine);
      print("Mines: $mines");


      return {
        "success": true,
        "data": mines,
        "message": "Mines retrieved successfully"
      };


    }

    return minesJson;
  }
  getAllMines() async {
    String apiUrl = "${Urls.BASE_URL}/get_all_mines";
    String method = "GET";


    final minesJson =  await httpsRequest(jsonEncode({}), apiUrl, method);

    print("Json response: $minesJson");
    if (minesJson['success']) {
      List<Mine> mines = [] ;
      for (var mine in minesJson['data']) {
        mines.add(Mine.fromJson(mine));
      }
      // Mine mine = Mine.fromJson(minesJson);
      // mines.add(mine);
      print("Mines: $mines");


      return {
        "success": true,
        "data": mines,
        "message": "Mines retrieved successfully"
      };


    }

    return minesJson;
  }


  getMineById(String mineId, String mineOwner) async{
    showProcessingDialog(context);
    String apiUrl = "${Urls.BASE_URL}/getMine" ;
    String method  =  "POST";
    var payload = {
      "mineId": mineId,
      "ownerId":  mineOwner
    };
    final mineJson =  await httpsRequest(jsonEncode(payload), apiUrl, method);
    if (mineJson['success']){
      Mine mine =  Mine.fromJson(mineJson['data']);
      await dismissDialog(context);

      return {
        "success": true,
        "data": mine,
        "message": "Mine retrieved"
      };
    }

    await dismissDialog(context);

    return mineJson ;

  }
}