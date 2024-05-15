import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/globals.dart';
import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_icon_button.dart';

import '../../widgets/custom_text_form_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullNameController  = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(24.h),
            child: Column(children: [
              SizedBox(
                  height: 70.adaptSize,
                  width: 70.adaptSize,
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    CustomImageView(
                        // imagePath: ImageConstant.imgRectangle361,
                        imagePath: "assets/images/profile_placeholder.png",
                        height: 70.adaptSize,
                        width: 70.adaptSize,
                        radius: BorderRadius.circular(35.h),
                        alignment: Alignment.center),
                    CustomIconButton(
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        padding: EdgeInsets.all(6.h),
                        decoration: IconButtonStyleHelper.outlineGrayTL12,
                        alignment: Alignment.bottomRight,
                        onTap: () {
                          onTapBtnTelevision(context);
                        },
                        child: CustomImageView(
                            imagePath: ImageConstant.imgTelevisionGray50))
                  ])),

              SizedBox(height: 4.v),
              Text(
                  globalEmail,
                  style: CustomTextStyles.titleSmallBluegray500Medium),
              SizedBox(height: 31.v),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Wallet Details",
                      style: CustomTextStyles.titleSmallBluegray500)),
              // SizedBox(height: 15.v),
              Divider(),
              _buildMyFavorites(context, text: "Wallet Address",
                  onTapMyFavorites: () {
                onTapMyFavorites(context);
              }, icon: Icons.wallet, data: globalUuid, show_edit_icon: false
              ),
              // _buildFullName(context),

              // SizedBox(height: 16.v),
              // Divider(height: 20,),
              SizedBox(height: 16.v),


              SizedBox(height: 5.v)
            ])));
  }

  Widget _buildFullName(BuildContext context) {
    return CustomTextFormField(
      controller: fullNameController, hintText: "Full name",
      autofocus: false,
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 64.h,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: AppbarSubtitleTwo(text: "Profile"),
        // styleType: Style.bgFill
    );
  }

  /// Common widget
  Widget _buildMyFavorites(
    BuildContext context, {
    required String text,
        required IconData icon,
        required String data,
        required bool show_edit_icon,
    Function? onTapMyFavorites,
        
  }) {
    return GestureDetector(
        onTap: () {
          onTapMyFavorites!.call();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, 
                children: [
              
              Container(
                child: Icon(
                  icon,
                  color: Colors.black54,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 6.h, top: 12.v, bottom: 7.v),
                  child: Text(text,
                      style: theme.textTheme.titleSmall!
                          .copyWith(
                           fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primaryContainer,

                      )
                  )
              ),
              Spacer(),
              Container(
                child: show_edit_icon?Container(
                  // imagePath: ImageConstant.img1,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  child: Icon(
                      Icons.edit_note
                  ),
                  // margin: EdgeInsets.symmetric(vertical: 10.v)
                ):Container(
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                )
              )
            ]
            ),
            Container(
                padding: EdgeInsets.only(left: 30.h),
                child: Text(data,
                    style: theme.textTheme.titleSmall!
                        .copyWith(color: theme.colorScheme.primaryContainer)
                )
            ),
          ],
        )
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the editProfileScreen when the action is triggered.
  onTapBtnTelevision(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.editProfileScreen);
  }

  /// Navigates to the recentlyViewsScreen when the action is triggered.
  onTapMyFavorites(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recentlyViewsScreen);
  }

  /// Navigates to the favoriteScreen when the action is triggered.
  onTapMyFavorites1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.favoriteScreen);
  }

  /// Navigates to the pastToursScreen when the action is triggered.
  onTapMyFavorites2(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pastToursScreen);
  }

  /// Navigates to the homeListingScreen when the action is triggered.
  onTapMyFavorites3(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeListingScreen);
  }

  /// Navigates to the settingsScreen when the action is triggered.
  onTapMyFavorites4(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settingsScreen);
  }
}
