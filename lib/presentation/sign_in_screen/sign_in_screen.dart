import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_elevated_button.dart';
import 'package:mineclaim/widgets/custom_outlined_button.dart';
import 'package:mineclaim/widgets/custom_text_form_field.dart';

import '../../widgets/dialogs.dart';

// ignore_for_file: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: PrimaryColors().appDarkBlue,
          title: Text(
            "Sign In"

          ),
        ),
        body: SizedBox(
            width: SizeUtils.width,
            child: Container(
              // padding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom
              // ),
              child: Column(
                children: [
                  Flexible(

                      child: Form(
                          key: _formKey,
                          child: Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(horizontal: 24.h),
                              child: Column(
                                  children: [
                                    // SizedBox(height: 40.v),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 30.h),
                                      child:Image.asset("assets/images/mineclaim.png"),
                                    ),
                                    // Spacer(),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Sign in to your account",
                                            style: theme.textTheme.bodyLarge)),
                                    SizedBox(height: 38.v),
                                    _buildPhoneNumber(context),
                                    SizedBox(height: 16.v),
                                    _buildPassword(context),
                                    SizedBox(height: 24.v),
                                    _buildSignIn(context),
                                    SizedBox(height: 8.v),
                                    Text("Forgot password?",
                                        style:
                                        CustomTextStyles.titleSmallBluegray500_1),
                                    // Spacer(),
                                    SizedBox(height: 30.v),
                                    Text("Or continue with following",
                                        style: theme.textTheme.bodyLarge),
                                    SizedBox(height: 24.v),
                                    _buildGoogle(context),
                                    SizedBox(height: 12.v),
                                    // _buildFacebook(context),
                                    // SizedBox(height: 25.v),
                                    Padding(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 41.h),
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                  padding:
                                                  EdgeInsets.only(bottom: 1.v),
                                                  child: Text(
                                                      "Don’t have an account?",
                                                      style:
                                                      theme.textTheme.bodyLarge)),
                                              GestureDetector(
                                                  onTap: () {
                                                    onTapTxtSignUp(context);
                                                  },
                                                  child: Padding(
                                                      padding:
                                                      EdgeInsets.only(left: 4.h),
                                                      child: Text("Sign Up",
                                                          style: CustomTextStyles
                                                              .titleMediumPrimary)))
                                            ])),
                                    SizedBox(height: 60.v)
                              ]
                              )
                          )
                      )
                  ),
                ],
              ),
            )));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: AppbarSubtitle(
            text: "Sign In", margin: EdgeInsets.only(left: 24.h),

        )
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return CustomTextFormField(
        controller: phoneNumberController,
        hintText: "Email Address",
        textInputType: TextInputType.emailAddress,
        autofocus: false,
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
        controller: passwordController,
        hintText: "Password",
        autofocus: false,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        suffix: Container(
            margin: EdgeInsets.fromLTRB(30.h, 14.v, 14.h, 14.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgEye,
                height: 20.adaptSize,
                width: 20.adaptSize)),
        suffixConstraints: BoxConstraints(maxHeight: 49.v),
        obscureText: true,
        contentPadding: EdgeInsets.only(left: 14.h, top: 14.v, bottom: 14.v));
  }

  /// Section Widget
  Widget _buildSignIn(BuildContext context) {
    return CustomElevatedButton(
        text: "Sign In",
      onPressed: () async {
          print("===================== Init Sign In ====================");
          onTapSignIn(context);
          print("================== Finished Sign In ======================");
      },
    );
  }

  /// Section Widget
  Widget _buildGoogle(BuildContext context) {
    return CustomOutlinedButton(
        text: "Phone",
        // leftIcon: Container(
        //     // margin: EdgeInsets.only(right: 1.h),
        //     child: CustomImageView(
        //         imagePath: ImageConstant.imgGoogle,
        //         height: 24.adaptSize,
        //         width: 24.adaptSize)
        // )
    );
  }

  /// Section Widget
  Widget _buildFacebook(BuildContext context) {
    return CustomOutlinedButton(
        text: "Facebook",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 12.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgFacebook,
                height: 24.adaptSize,
                width: 24.adaptSize)));
  }

  /// Navigates to the signUpScreen when the action is triggered.
  onTapTxtSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
  onTapSignIn(BuildContext context) async {
    try {
      showProcessingDialog(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "tinashemashaya18@gmail.com",
        password: "Tinashe2023",
      );
      await dismissDialog(context);
      Navigator.pushNamed(context, AppRoutes.myHomeEmptyScreen);
    } on FirebaseAuthException catch (e) {
      await dismissDialog(context);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showInformativeDialog("Failed", Colors.black54, "Wrong email or password provided", context);

      } else if (e.code == 'wrong-password') {
        print('Wrong email or password provided');
        showInformativeDialog("Failed", Colors.black54, "Wrong email or password provided", context);
      }
    }
  }
}
