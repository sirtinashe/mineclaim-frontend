import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/globals.dart';
import 'package:mineclaim/presentation/confirm_request_screen/confirm_request_screen.dart';
import 'package:mineclaim/presentation/mine_gallery_screen/claim_mine.dart';
import 'package:mineclaim/presentation/my_home_empty_screen/empty_mines.dart';
import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_checkbox_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../helper.dart';
import '../../models/mine.dart';
import '../../widgets/dialogs.dart';


// import api calls
import '../../apis/api_calls.dart';
import '../presentation/transfer_mine/transfer_mine_screen.dart';


// ignore_for_file: must_be_immutable
class PersonalMinesWidget extends StatefulWidget {
  PersonalMinesWidget({Key? key}) : super(key: key);

  @override
  State<PersonalMinesWidget> createState() => _PersonalMinesWidgetState();
}

class _PersonalMinesWidgetState extends State<PersonalMinesWidget> {
  bool complete = false;
  late Future<Map<String,dynamic>> futureMines;

  // Column(children: [
  bool minesAvailable = false ;
  String message = "No mines available";
  // Stream<QuerySnapshot>? stream;

  Future<Map<String ,dynamic>>_getMines() async {

    return await MineclaimApi(context).getMines(globalUuid);
  }
  @override
  void initState() {
    super.initState();
    futureMines = _getMines();
    // stream = FirebaseFirestore.instance
    //     .collection('claimed_by_$globalUuid')
    //     .snapshots();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7EEFA),
      // appBar: _buildAppBar(context),
      // body: !minesAvailable ? _mineAvailable(context) : EmptyMinesScreen(),

    );
  }





  /// Section Widget

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
