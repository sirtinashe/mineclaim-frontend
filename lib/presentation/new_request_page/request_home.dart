// import '../my_home_page/widgets/propertylist_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/presentation/new_request_page/widgets/request_widget.dart';

import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


import '../../globals.dart';
import '../../helper.dart';
import '../../models/requests.dart';
import 'outgoing_request_page.dart';

class RequestHomeScreen extends StatefulWidget {
  RequestHomeScreen({Key? key}) : super(key: key);

  @override
  State<RequestHomeScreen> createState() => _RequestHomeScreenState();
}

class _RequestHomeScreenState extends State<RequestHomeScreen> {

  Stream<QuerySnapshot>? stream; // Declaring Stream

  @override
  void initState() {
    super.initState();

    stream = FirebaseFirestore.instance
        .collection(globalUuid)
         .where('ownerUid', isEqualTo: "`${globalUuid}`")
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: _buildAppBar(context),
        // body: _buildPropertyList(context),
      backgroundColor: Color(0xffF5F5F5),
       appBar:  AppBar(
         elevation: 2,
         foregroundColor: Colors.white,
         centerTitle: true,
         backgroundColor: PrimaryColors().appDarkBlue,
         title: Text(
           "Requests",
           style: TextStyle(
             color: Colors.white,
           ),
         ),
       ),
        body: Container(
            width: double.maxFinite,
            color: Color(0xFFE7EEFA),
            padding: EdgeInsets.only(left:24.h, right: 24.h),
            child: Column(children: [
              Expanded(
                  child: _buildPropertyList(context)
              ),

            ]
            )

        ),
    //   floatingActionButton: FloatingActionButton.extended(
    //     heroTag: "btn1",
    // backgroundColor: Colors.white,
    //   foregroundColor: Colors.blue,
    //   onPressed: () {
    //     // Respond to button press
    //     PersistentNavBarNavigator.pushNewScreen(
    //       context,
    //       screen: NewRequestPage(),
    //       withNavBar: false, // OPTIONAL VALUE. True by default.
    //       pageTransitionAnimation: PageTransitionAnimation.cupertino,
    //     );
    //   },
    //   icon: Icon(Icons.create),
    //   label: Text(
    //     'Create a request',
    //     style: TextStyle(
    //         // fontWeight: FontWeight.w700,
    //         // fontSize: 16
    //     ),
    //   ),
    // )
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 64.h,

        centerTitle: true,
        title: AppbarSubtitleTwo(text: "Requests"),
        // styleType: Style.bgFill
    );
  }

  /// Section Widget
  Widget _buildPropertyList(BuildContext context) {
    // return Container(
    //   child: ListView.builder(
    //       physics: NeverScrollableScrollPhysics(),
    //       shrinkWrap: true,
    //
    //       itemCount: requestData.length,
    //
    //       itemBuilder: (context, index) {
    //         return Card(
    //           child: Padding(
    //             padding: EdgeInsets.only(bottom: 10.0.v),
    //             child: RequestWidget(
    //               requestData: requestData[index],
    //
    //             ),
    //           ),
    //         );
    //       }),
     return Container(
       child: StreamBuilder<QuerySnapshot>(
       stream: stream,
       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
         if (snapshot.hasError)
           return Text('Something went wrong');
         if (snapshot.connectionState == ConnectionState.waiting)
           return Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   CircularProgressIndicator(
                     color: PrimaryColors().appDarkBlue,
                   ),
                   Text("Fetching your requests..."),
                 ],
               )
           );
         List<DocumentSnapshot> documents = snapshot.data!.docs;
         List<Requests> serializedRequests =  RequestSerializer.serialize(documents);
         return ListView.builder(
           itemCount: serializedRequests.length,
           itemBuilder: (BuildContext context, int index) {
             // DocumentSnapshot document = documents[index];
             Requests requests = serializedRequests[index];
             // print(document);
             return Card(
               child: Padding(
                 padding: EdgeInsets.only(bottom: 10.0.v),
                 child: RequestWidget(
                   requestData: serializedRequests[index],

                 ),
               ),
             );
           },
         );
       },
     ),
    );
  }

  onTapProperty(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productDetailsScreen);
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
