import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_elevated_button.dart';
import 'package:mineclaim/widgets/custom_icon_button.dart';

import '../../widgets/app_bar/new_app_bar.dart';

class ConfirmRequestScreen extends StatelessWidget {
  const ConfirmRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7EEFA),
        appBar: AppBar(
          elevation: 2,
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: PrimaryColors().appDarkBlue,
          title: Text(
            "Success Page",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(24.h),
              child: Column(children: [
                SizedBox(height: 150.v),
                _buildConfirm(context),


                SizedBox(height: 50.v),
                Container(
                    margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 24.v),
                    decoration: AppDecoration.outlineBlueGrayF,
                    child: CustomElevatedButton(
                      buttonStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF152A47)),
                      ),
                      
                        text: "Done",
                        onPressed: () {

                        }))
              ]
              )
          ),
        ),
        // bottomNavigationBar: _buildBtn(context)
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: double.maxFinite,
        // leading: AppbarLeadingIconbutton(
        //     imagePath: ImageConstant.imgArrowLeftPrimarycontainer,
        //     margin: EdgeInsets.fromLTRB(24.h, 8.v, 311.h, 8.v),
        //     onTap: () {
        //       onTapArrowLeft(context);
        //     }
        //     ),
        // styleType: Style.bgFill
    );
  }

  /// Section Widget
  Widget _buildConfirm(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 23.h, vertical: 30.v),
        decoration: AppDecoration.fillPrimary
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.v,
                child:  CustomImageView(
                  imagePath: "assets/app_icons/share.png",
                ),
              ),
              SizedBox(height: 12.v),
              Text("Request sent!",
                  style: CustomTextStyles.titleMediumBold_1
              ),
              SizedBox(height: 8.v),
              SizedBox(
                  width: 278.h,
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Request was send to\n",

                        ),
                        TextSpan(
                            text: "#3775774733",
                            style: CustomTextStyles.titleMediumBold_1),


                      ]),
                      textAlign: TextAlign.center)
              )
            ]
        )
    );
  }




  /// Section Widget
  Widget _buildBtn(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 24.v),
        decoration: AppDecoration.outlineBlueGrayF,
        child: CustomElevatedButton(
            text: "Done",
            onPressed: () {

            }));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }


}
