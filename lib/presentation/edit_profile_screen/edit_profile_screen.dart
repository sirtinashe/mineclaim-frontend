import 'package:flutter/material.dart';import 'package:mineclaim/core/app_export.dart';import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';import 'package:mineclaim/widgets/custom_elevated_button.dart';import 'package:mineclaim/widgets/custom_icon_button.dart';import 'package:mineclaim/widgets/custom_text_form_field.dart';
// ignore_for_file: must_be_immutable
class EditProfileScreen extends StatelessWidget {EditProfileScreen({Key? key}) : super(key: key);

TextEditingController editProfileFullNameController = TextEditingController();

TextEditingController editProfileEmailController = TextEditingController();

TextEditingController editProfileAddressController = TextEditingController();

TextEditingController editProfilePasswordController = TextEditingController();

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override Widget build(BuildContext context) { return SafeArea(child: Scaffold(resizeToAvoidBottomInset: false, appBar: _buildAppBar(context), body: SizedBox(width: SizeUtils.width, child: SingleChildScrollView(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), child: Form(key: _formKey, child: Container(width: double.maxFinite, padding: EdgeInsets.all(24.h), child: Column(children: [SizedBox(height: 100.adaptSize, width: 100.adaptSize, child: Stack(alignment: Alignment.bottomRight, children: [CustomImageView(imagePath: ImageConstant.imgRectangle361100x100, height: 100.adaptSize, width: 100.adaptSize, radius: BorderRadius.circular(50.h), alignment: Alignment.center), CustomIconButton(height: 24.adaptSize, width: 24.adaptSize, padding: EdgeInsets.all(6.h), decoration: IconButtonStyleHelper.outlineGrayTL121, alignment: Alignment.bottomRight, child: CustomImageView(imagePath: ImageConstant.imgTelevisionGray50))])), SizedBox(height: 33.v), Align(alignment: Alignment.centerLeft, child: Text("Full Name", style: theme.textTheme.labelLarge)), SizedBox(height: 7.v), _buildEditProfileFullName(context), SizedBox(height: 17.v), Align(alignment: Alignment.centerLeft, child: Text("Email", style: theme.textTheme.labelLarge)), SizedBox(height: 7.v), _buildEditProfileEmail(context), SizedBox(height: 17.v), Align(alignment: Alignment.centerLeft, child: Text("Address", style: theme.textTheme.labelLarge)), SizedBox(height: 7.v), _buildEditProfileAddress(context), SizedBox(height: 17.v), Align(alignment: Alignment.centerLeft, child: Text("Password", style: theme.textTheme.labelLarge)), SizedBox(height: 7.v), _buildEditProfilePassword(context), SizedBox(height: 5.v)]))))), bottomNavigationBar: _buildBtn(context))); } 
/// Section Widget
PreferredSizeWidget _buildAppBar(BuildContext context) { return CustomAppBar(leadingWidth: 64.h, leading: AppbarLeadingIconbutton(imagePath: ImageConstant.imgArrowLeftPrimarycontainer, margin: EdgeInsets.only(left: 24.h, top: 8.v, bottom: 8.v), onTap: () {onTapArrowLeft(context);}), centerTitle: true, title: AppbarSubtitleTwo(text: "Edit Profile"), styleType: Style.bgFill); } 
/// Section Widget
Widget _buildEditProfileFullName(BuildContext context) { return CustomTextFormField(controller: editProfileFullNameController, hintText: "Andrew Preston"); } 
/// Section Widget
Widget _buildEditProfileEmail(BuildContext context) { return CustomTextFormField(controller: editProfileEmailController, hintText: "test@gmail.com", textInputType: TextInputType.emailAddress); } 
/// Section Widget
Widget _buildEditProfileAddress(BuildContext context) { return CustomTextFormField(controller: editProfileAddressController, hintText: "Merta Nadi Street 88, Kuta, Bali"); } 
/// Section Widget
Widget _buildEditProfilePassword(BuildContext context) { return CustomTextFormField(controller: editProfilePasswordController, hintText: "123456", textInputAction: TextInputAction.done, textInputType: TextInputType.visiblePassword, obscureText: true); } 
/// Section Widget
Widget _buildSaveChange(BuildContext context) { return CustomElevatedButton(text: "Save Change"); } 
/// Section Widget
Widget _buildBtn(BuildContext context) { return Container(margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 24.v), decoration: AppDecoration.outlineBlueGrayF, child: _buildSaveChange(context)); } 

/// Navigates back to the previous screen.
onTapArrowLeft(BuildContext context) { Navigator.pop(context); } 
 }
