import '../notification_screen/widgets/todaysection_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  List todaysectionItemList = [
    {'id': 1, 'groupBy': "Today"},
    {'id': 2, 'groupBy': "Today"},
    {'id': 3, 'groupBy': "This Week"},
    {'id': 4, 'groupBy': "This Week"},
    {'id': 5, 'groupBy': "This Week"},
    // {'id': 5, 'groupBy': "Last Week"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: Color(0xFFE7EEFA),
        body: Padding(
            padding: EdgeInsets.fromLTRB(24.h, 27.v, 24.h, 5.v),
            child: GroupedListView<dynamic, String>(
                shrinkWrap: true,
                stickyHeaderBackgroundColor: Colors.transparent,
                elements: todaysectionItemList,
                groupBy: (element) => element['groupBy'],
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
                  return TodaysectionItemWidget();
                },
                separator: SizedBox(height: 14.v)
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
