import '../message_page/widgets/messages_item_widget.dart';import 'package:flutter/material.dart';import 'package:mineclaim/core/app_export.dart';import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';class MessagePage extends StatelessWidget {const MessagePage({Key? key}) : super(key: key);

@override Widget build(BuildContext context) { return SafeArea(child: Scaffold(appBar: _buildAppBar(context), body: Container(width: double.maxFinite, decoration: AppDecoration.fillGray50, child: Column(children: [SizedBox(height: 34.v), _buildMessages(context), Spacer()])))); } 
/// Section Widget
PreferredSizeWidget _buildAppBar(BuildContext context) { return CustomAppBar(leadingWidth: 64.h, leading: AppbarLeadingIconbutton(imagePath: ImageConstant.imgArrowLeftPrimarycontainer, margin: EdgeInsets.only(left: 24.h, top: 8.v, bottom: 8.v), onTap: () {onTapArrowLeft(context);}), centerTitle: true, title: AppbarSubtitleTwo(text: "Message"), styleType: Style.bgFill); } 
/// Section Widget
Widget _buildMessages(BuildContext context) { return Padding(padding: EdgeInsets.symmetric(horizontal: 24.h), child: ListView.separated(physics: NeverScrollableScrollPhysics(), shrinkWrap: true, separatorBuilder: (context, index) {return Padding(padding: EdgeInsets.symmetric(vertical: 8.0.v), child: SizedBox(width: 327.h, child: Divider(height: 1.v, thickness: 1.v, color: appTheme.gray300)));}, itemCount: 5, itemBuilder: (context, index) {return MessagesItemWidget(onTapMsg: () {onTapMsg(context);});})); } 
/// Navigates to the messageChatScreen when the action is triggered.
onTapMsg(BuildContext context) { Navigator.pushNamed(context, AppRoutes.messageChatScreen); } 

/// Navigates back to the previous screen.
onTapArrowLeft(BuildContext context) { Navigator.pop(context); } 
 }
