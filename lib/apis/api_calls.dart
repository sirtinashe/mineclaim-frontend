import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/dialogs.dart';

class MineclaimApi {
  late BuildContext context;
  MineclaimApi(BuildContext context) {
    this.context = context;
  }
  String method = "";
  httpsRequest(payload, apiUrl, method) async {
    var client = http.Client();
    final http.Response response;
    showProcessingDialog(context);

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
        Navigator.of(context).pop();
        return jsonDecode(response.body);
      } else {
        Navigator.of(context).pop();
        print("RESPONSE: ${response.body}");
        showInformativeDialog("Message", Colors.black54,
            jsonDecode(response.body)['message'], context);
        return -1;
      }
    } on FormatException catch (e) {
      // Handle the format exception
      print("FormatException $e");
      // Navigator.of(context).pop();
      showInformativeDialog('Error', Colors.red,
          "Sorry, server info error. Try again later!", context);
      return -1;
    } on SocketException catch (e) {
      // Handle the socket exception
      print("SocketException $e");
      // Navigator.of(context).pop();
      showInformativeDialog('Error', Colors.red,
          "There is a problem with the network connection!", context);
      return -1;
    } on Exception catch (_, e) {
      // Handle any other exception
      print("Exception captured $e");
      // Navigator.of(context).pop();
      showInformativeDialog(
          'Error', Colors.red, "An unknown error occurred!", context);
      return -1;
    } finally {
      // Perform some cleanup actions
      client.close();
    }
  }

  // Future add mine
  Future addMine(Map<String, dynamic> payload) async {
    String apiUrl = "https://mineclaim.com/api/v1/mines";
    String method = "POST";
    return await httpsRequest(jsonEncode(payload), apiUrl, method);
  }
}