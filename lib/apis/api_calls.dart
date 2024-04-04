import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mineclaim/models/mine.dart';

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
              .timeout(const Duration(seconds: 15)
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
          ).timeout(const Duration(seconds: 15));
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
          ).timeout(const Duration(seconds: 15));
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

  // Future add mine
  Future addMine(Map<String, dynamic> payload) async {
    String apiUrl = "http://10.0.2.2:5000/mineByOwner";
    String method = "POST";
    return await httpsRequest(jsonEncode(payload), apiUrl, method);
  }
  getMines(String mineOwner) async {
    String apiUrl = "http://10.0.2.2:5000/mineByOwner";
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
}