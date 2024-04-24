import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/presentation/profile_page/profile_page.dart';
import 'package:mineclaim/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_switch.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


// ignore_for_file: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  bool isSelectedSwitch = false;

  bool isSelectedSwitch1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: Color(0xFFE7EEFA),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 26.v),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Settings",
                      style: CustomTextStyles.titleSmallBluegray500),
                  SizedBox(height: 14.v),
                  _buildNotificationRow(context),
                  SizedBox(height: 16.v),
                  Divider(height: 5.v,),

                 // SizedBox(height: 16.v),
                  _buildProfileRow(context),
                  // SizedBox(height: 16.v),
                  Divider(height: 5.v,),
                 // Divider(),
                 // Divider(),

                  SizedBox(height: 15.v),
                 
                  Text("Logout",
                      style: CustomTextStyles.titleSmallBluegray500),
                  SizedBox(height: 14.v),
                  _buildLogout(context),
                ]
            )
        )
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 64.h,

        centerTitle: true,
        title: AppbarSubtitleTwo(text: "Settings"),
        // styleType: Style.bgFill
    );
  }

  /// Section Widget
  Widget _buildNotificationRow(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 2.v, bottom: 1.v),
          child: Text("Notification", style: theme.textTheme.titleSmall)),
      CustomSwitch(
          value: isSelectedSwitch,
          onChange: (value) {
            isSelectedSwitch = value;
          })
    ]);
  }

  Widget _buildLogout(
      BuildContext context) {
    return GestureDetector(
      onTap: (){
        // onTapProfile(context);
        onTapSignOut(context);

      },
      child: Row(children: [
        Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Text("Logout",
                style: theme.textTheme.titleSmall!
                    .copyWith(color: theme.colorScheme.primaryContainer)
            )
        ),
        Spacer(),

        Container(
          child: IconButton(
              onPressed: (){
                // onTapProfile(context);
                onTapSignOut(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black54,

              )
          ),
        )
      ]),
    );
  }

  /// Common widget
  Widget _buildProfileRow(
    BuildContext context) {
    return GestureDetector(
      onTap: (){
       onTapProfile(context);
      },
      child: Row(children: [
        Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Text("Profile",
                style: theme.textTheme.titleSmall!
                    .copyWith(color: theme.colorScheme.primaryContainer)
            )
        ),
        Spacer(),

        Container(
         child: IconButton(
             onPressed: (){
               onTapProfile(context);
             },
             icon: Icon(
                 Icons.edit_note,
              color: Colors.black54,

             )
         ),
        )
      ]),
    );
  }

  /// Common widget
  Widget _buildPrivacyPolicyRow(
    BuildContext context, {
    required String privacyPolicyText,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(privacyPolicyText,
              style: theme.textTheme.titleSmall!
                  .copyWith(color: theme.colorScheme.primaryContainer))),
      CustomImageView(
          imagePath: ImageConstant.imgArrowRightBlueGray500,
          height: 20.adaptSize,
          width: 20.adaptSize,
          margin: EdgeInsets.only(bottom: 2.v))
    ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the faqsGetHelpScreen when the action is triggered.
  onTapPrivacyPolicyRow(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.faqsGetHelpScreen);
  }
  onTapProfile(BuildContext context) {
   PersistentNavBarNavigator.pushNewScreen(
    context,
    screen: ProfilePage(),
    withNavBar: false, // OPTIONAL VALUE. True by default.
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
   );
  }
  onTapSignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    // Sign Out

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil( MaterialPageRoute( builder: (BuildContext context) { return SignInScreen(); }, ), (_) => false, );

    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
    // Navigator.of(context).pushAndRemoveUntil(
    //   CupertinoPageRoute(
    //     builder: (BuildContext context) {
    //       return SignInScreen();
    //     },
    //   ),
    //   (_) => false,
    // );
    // Navigator.of(context).popUntil((route) {
    //     return route.settings.name == AppRoutes.signUpScreen;
    // });
    // PersistentNavBarNavigator.(
    //   context,
    //   screen: SignInScreen(),
    //   withNavBar: false, // OPTIONAL VALUE. True by default.
    //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
    // );

    
    // Navigator.of(context).popUntil(ModalRoute.withName("/"));

  }
}

