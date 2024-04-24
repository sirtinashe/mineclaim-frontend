

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../globals.dart';
import '../../models/notifications.dart';
import '../notification_screen/widgets/todaysection_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Stream<QuerySnapshot>? stream;

  List todaysectionItemList = [
    {'id': 1, 'groupBy': "Today"},
    {'id': 2, 'groupBy': "Today"},
    {'id': 3, 'groupBy': "This Week"},
    {'id': 4, 'groupBy': "This Week"},
    {'id': 5, 'groupBy': "This Week"},
    // {'id': 5, 'groupBy': "Last Week"}
  ];

  Map<String, dynamic> groupByDate(dynamic element) {
    // final DateTime itemDate = element['timestamp'];
    Timestamp timeAdded = element['timeAdded'];
    DateTime itemDate = timeAdded.toDate();
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime thisWeek = today.subtract(Duration(days: today.weekday - 1));

    if (itemDate.isAfter(today)) {
      return {'group': 'Today'};
    } else if (itemDate.isAfter(thisWeek)) {
      return {'group': 'This Week'};
    } else {
      return {'group': 'Older'};
    }
  }
  @override
  void initState() {
    super.initState();

    stream = FirebaseFirestore.instance
        .collection('notifications')
        .where('mineOwner', isEqualTo: globalUuid)
        .snapshots();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: Color(0xFFE7EEFA),
        body: Padding(
            padding: EdgeInsets.fromLTRB(24.h, 27.v, 24.h, 5.v),
            child: StreamBuilder<Object>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = snapshot.data as QuerySnapshot;
                // print(documents.docs);
                for (var doc in documents.docs) {
                  print(doc.data());
                }
                if(documents.size == 0){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   "assets/images/empty_requests.png",
                        //   height: 200.h,
                        //   width: 200.h,
                        // ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "No notifications available",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return GroupedListView<dynamic, String>(
                    shrinkWrap: true,
                    stickyHeaderBackgroundColor: Colors.transparent,
                    elements: documents.docs,
                    groupBy: (element) => groupByDate(element)['group'],
                    sort: false,
                    groupSeparatorBuilder: (String value) {
                      return Padding(
                          padding: EdgeInsets.only(top: 22.v, bottom: 17.v),
                          child: Column(children: [
                            Text(value,
                                style: CustomTextStyles.titleMediumBold
                                    .copyWith(
                                        color:
                                            theme.colorScheme.primaryContainer))
                          ]));
                    },
                    itemBuilder: (context, model) {
                      print("Model data $model");
                      Notifications notification = Notifications.fromJson(model.data());
                      return TodaysectionItemWidget(
                        dataModel: notification,

                      );
                    },
                    separator: SizedBox(height: 14.v)
                );
              }
            )
        )
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 64.h,
        // leading: AppbarLeadingIconbutton(
        //     imagePath: ImageConstant.imgArrowLeftPrimarycontainer,
        //     margin: EdgeInsets.only(left: 24.h, top: 8.v, bottom: 8.v),
        //     onTap: () {
        //       onTapArrowLeft(context);
        //     }),
        centerTitle: true,
        title: AppbarSubtitleTwo(text: "Notifications"),
        // styleType: Style.bgFill
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
