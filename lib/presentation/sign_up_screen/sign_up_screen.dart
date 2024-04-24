import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_elevated_button.dart';
import 'package:mineclaim/widgets/custom_outlined_button.dart';
import 'package:mineclaim/widgets/custom_text_form_field.dart';
import 'package:mineclaim/widgets/dialogs.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: PrimaryColors().appDarkBlue,
          automaticallyImplyLeading: false,
          title: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Create a ",
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    )
                ),
                TextSpan(
                    text: "Mineclaim account",
                    style: CustomTextStyles.headlineSmallff1786f9)
              ]),
              textAlign: TextAlign.left),
        ),
        body: SizedBox(
            width: SizeUtils.width,
            child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                    key: _formKey,
                    child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        child: Column(children: [
                          SizedBox(height: 80.v),
                         // Spacer(),
                          Container(
                            child:Image.asset("assets/images/mineclaim.png"),
                          ),
                         // SizedBox(height: 180.v),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Create an account to continue",
                                  style: theme.textTheme.bodyLarge)),
                          SizedBox(height: 40.v),
                          _buildFullName(context),
                          SizedBox(height: 16.v),
                          _buildPhoneNumber(context),
                          SizedBox(height: 16.v),
                          _buildPassword(context),
                          SizedBox(height: 24.v),
                          _buildSignUp(context),
                          SizedBox(height: 45.v),
                          Text("Or sign up with the following",
                              style: theme.textTheme.bodyLarge),
                          SizedBox(height: 24.v),
                          _buildGoogle(context),
                          SizedBox(height: 12.v),
                          // _buildFacebook(context),
                          // SizedBox(height: 27.v),
                          Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 21.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text("You already have an account?",
                                        style: theme.textTheme.bodyLarge),
                                    GestureDetector(
                                        onTap: () {
                                          onTapTxtSignUp(context);
                                        },
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 4.h),
                                            child: Text("Sign In",
                                                style: CustomTextStyles
                                                    .titleMediumPrimary)))
                                  ])),
                          SizedBox(height: 5.v)
                        ]))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: Padding(
            padding: EdgeInsets.only(left: 24.h),
            child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Create a ",
                      style: CustomTextStyles.headlineSmallff16161a),
                  TextSpan(
                      text: "Mineclaim account",
                      style: CustomTextStyles.headlineSmallff1786f9)
                ]),
                textAlign: TextAlign.left)
        ));
  }

  /// Section Widget
  Widget _buildFullName(BuildContext context) {
    return CustomTextFormField(
        controller: fullNameController, hintText: "Full name",
         autofocus: false,
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return CustomTextFormField(
        controller: emailController,
        hintText: "Email",
        autofocus: false,

        textInputType: TextInputType.emailAddress

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
  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
        text: "Sign Up",
      onPressed: () async {
          print("================== Signing Up =======================");
          // await onTapSignUpWithPhone();
          onTapSignUpWithEmail(context);
          print("================== Finished Signing Up =======================");
        // Navigator.pushNamed(context, AppRoutes.verifyPhoneNumberScreen);

      },


    );
  }

  /// Section Widget
  Widget _buildGoogle(BuildContext context) {
    return CustomOutlinedButton(
        text: "Phone",
        // leftIcon: Container(
        //     margin: EdgeInsets.only(right: 12.h),
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
                width: 24.adaptSize)
        )
    );
  }

  /// Navigates to the signInScreen when the action is triggered.
  onTapTxtSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signInScreen);
  }


  onTapSignUpWithEmail(BuildContext context) async {
    try {
      //
      // progressIndicator(context);
      // progressIndicator(context,"Please Wait");
      // showInformativeDialog("Signing uP", Colors.black54, "Please wait...", context);
      showProcessingDialog(context);
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credential != null) {
        // User is authenticated
        print('User is authenticated.');
        await dismissDialog(context);
        Navigator.pushNamed(context, AppRoutes.myHomeEmptyScreen);

        // Perform any additional actions for authenticated users
      }
      print("================ Auth Details =====================");

      print("============= End of Auth Details ===============");

    } on FirebaseAuthException catch (e) {
      await dismissDialog(context);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        await showInformativeDialog("Failed", Colors.black54, 'The password provided is too weak.', context);
      } else if (e.code == 'email-already-in-use') {
        await showInformativeDialog("Failed", Colors.black54, 'The account already exists for that email.', context);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    } finally {
      // dismissDialog(context);
    }
  }
  onTapSignUpWithPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+263 71 292 6938',
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // progressIndicator
   progressIndicator(BuildContext context, String message) {
     return showDialog(
         context: context,
         builder: (BuildContext context) {
           return AlertDialog(
             actions: <Widget>[
               ElevatedButton(
                 style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                   foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                     RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(16),
                     ),
                   ),
                 ),
                 // onPressed: _goToLogin,
                 onPressed: () {
                   Navigator.of(context).pop();

                 },
                 child: const Text('Ok'),
               ),

             ],
             title: Text(message),
             content: Container(
               height: 50,
               child: Center(
                 child: CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                 ),
               ),
             ),
           );
         });

   }

}
