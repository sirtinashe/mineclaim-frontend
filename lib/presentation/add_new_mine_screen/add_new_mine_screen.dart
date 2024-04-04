import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/presentation/authorise_screen/authorise_screen.dart';
import 'package:mineclaim/presentation/confirm_request_screen/confirm_request_screen.dart';

import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_elevated_button.dart';
import 'package:mineclaim/widgets/custom_text_form_field.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../widgets/dialogs.dart';
import '../location_screens/location_picker_screen.dart';
import 'package:mineclaim/apis/firebase_db.dart';

// ignore_for_file: must_be_immutable
class AddNewMineScreen extends StatefulWidget {
  AddNewMineScreen({Key? key}) : super(key: key);

  @override
  State<AddNewMineScreen> createState() => _AddNewMineScreenState();
}

class _AddNewMineScreenState extends State<AddNewMineScreen> {
  TextEditingController addressController = TextEditingController();

  TextEditingController gpsGPSLongitudeController = TextEditingController();
  TextEditingController claimantController = TextEditingController();

  TextEditingController priceController = TextEditingController();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode gpsLongitudeFocusNode = FocusNode();
  final FocusNode addressNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode areaFocusNode = FocusNode();
  final FocusNode claimantNode = FocusNode();

  String gpsLatitude = "none";
  String gpsLongitude = "none";

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  TextEditingController areaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _selectedFile;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String fileUrl = "";

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);

          // FirebaseDB firebaseDB = FirebaseDB();
          // firebaseDB.uploadFile(_selectedFile!);
        });
      } else {
        setState(() {
          _selectedFile = null;
        });
      }
    } catch (e) {
      print('Error while picking the file: $e');
    }
  }
  // final _formKey = GlobalKey<FormState>();

// Method to validate TextField controllers
  validateInputs() {
    if (_formKey.currentState!.validate()) {
      // If all data are correct then save data to out variables
      _formKey.currentState!.save();
      print('All inputs are valid');
      return true;
    } else {
      // If any data is incorrect, stop the form submission
      print('Some inputs are incorrect');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: _buildAppBar(context),
        // appBar: MyAppBar(
        //   title: Text("Add New Mine"),
        // ),
        appBar: AppBar(
          elevation: 2,
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: PrimaryColors().appDarkBlue,
          title: Text(
            "Add New Mine",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
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
                        padding: EdgeInsets.all(24.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildAddressAndProgress(context),
                              SizedBox(height: 16.v),
                              Container(
                                  height: 6.v,
                                  width: 327.h,
                                  decoration: BoxDecoration(
                                      color: appTheme.gray300,
                                      borderRadius: BorderRadius.circular(3.h)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(3.h),
                                      child: LinearProgressIndicator(
                                          value: 0.5,
                                          backgroundColor: appTheme.gray300,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  theme.colorScheme.primary)))),
                              SizedBox(height: 26.v),
                              Text("Mine Details",
                                  style: CustomTextStyles.titleMediumBold_1),
                              SizedBox(height: 13.v),
                              // _buildMineLocation(context),
                              _buildClaimant(context),
                              SizedBox(height: 13.v),

                              _buildAddressField(context),
                              SizedBox(height: 12.v),
                              _selectLocation(context),
                              // SizedBox(height: 12.v),
                              // _buildPrice(context),

                              SizedBox(height: 12.v),
                              _AreaField(context),
                              SizedBox(height: 5.v),
                              _addFile(context),
                            ]))))),
        bottomNavigationBar: _buildBtn(context));
  }

  /// Section Widget
  Widget _buildButton(BuildContext context) {
    return CustomElevatedButton(
        height: 33.v,
        width: 76.h,
        text: "01 / 02",
        buttonStyle: CustomButtonStyles.fillPrimaryTL16,
        buttonTextStyle: CustomTextStyles.titleSmallWhiteA700);
  }

  /// Section Widget
  Widget _buildAddressAndProgress(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 7.v, bottom: 5.v),
          child: Text("Mine Details", style: theme.textTheme.titleSmall)),
      _buildButton(context)
    ]);
  }

  /// Section Widget
  Widget _buildAddressField(BuildContext context) {
    return CustomTextFormField(
      controller: addressController,
      hintText: "Physical Address",
      textInputType: TextInputType.text,
      autofocus: false,
      focusNode: addressNode,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please provide address";
        }
      },
    );
  }

  Widget _buildClaimant(BuildContext context) {
    return CustomTextFormField(
      controller: claimantController,
      hintText: "Claimant Name",
      textInputType: TextInputType.text,
      autofocus: false,
      focusNode: claimantNode,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please provide claimant name";
        }
      },
    );
  }

  /// Section Widget
  Widget _buildPrice(BuildContext context) {
    return CustomTextFormField(
      controller: priceController,
      hintText: "Price in USD",
      focusNode: priceFocusNode,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty || double.tryParse(value) == null) {
          return "Provide a valid amount";
        }
      },
    );
  }

  /// Section Widget
  Widget _AreaField(BuildContext context) {
    return CustomTextFormField(
      controller: areaController,
      hintText: "Area in sqm",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.number,
      focusNode: areaFocusNode,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty || double.tryParse(value) == null) {
          return "Provide a valid area";
        }
      },
    );
  }

  /// Section Widget
  Widget _buildNext(BuildContext context) {
    return CustomElevatedButton(
        text: "Add New Mine",
        onPressed: () async {
          // onTapNext(context);
          // addNewMine(context);
          // addNewMine(context);
          if (validateInputs()) {
            bool confirmation = await showActionDialog("Add Mine",
                Colors.black54, "Are you sure you want to add a mine", context);
            if (confirmation) {
              addNewMine(context);
              // showInformativeDialog("Mine Added", Colors.black54, "Mine added sucessfully. Please wait for the review from the ministry of mines", context);
            } else {
              showInformativeDialog("Mine Not Added", Colors.black54,
                  "Mine not added sucessfully. Please try again", context);
            }
          }
          // bool confirmation =  await showActionDialog("Add Mine", Colors.black54, "Are you sure you want to add a mine", context) ;
          // if(confirmation){
          //   addNewMine(context);
          //   // showInformativeDialog("Mine Added", Colors.black54, "Mine added sucessfully. Please wait for the review from the ministry of mines", context);
          // }else{
          //   showInformativeDialog("Mine Not Added", Colors.black54, "Mine not added sucessfully. Please try again", context);
          // }
        });
  }

  /// Section Widget
  Widget _buildBtn(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 24.v),
        decoration: AppDecoration.outlineBlueGrayF,
        child: _buildNext(context));
  }

  Widget _selectLocation(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapSelectLocation(context);
      },
      child: Container(
        width: 400.h,
        height: 52.v,
        padding: EdgeInsets.only(
          top: 16.v,
          left: 16.h,
        ),
        decoration: BoxDecoration(
          color: appTheme.gray300,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Text(
              "GPS Coordinates (optional)",
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            )),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _addFile(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              // height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: _selectedFile != null
                    ? _buildUploadedFile()
                    : _buildDefaultFile(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadedFile() {
    return Container(

        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 13.v),
        // decoration: AppDecoration.outlineGray300
        //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                  // radius: BorderRadius.circular(5.h),
                  // fit: BoxFit.fill,
                // take max width
                height: 180.v,
                  width: MediaQuery.of(context).size.width,
                child: Image.file(_selectedFile!),
              ),

              SizedBox(height: 13.v),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _isUploading = true;
                      setState(() {

                      });
                      FirebaseDB firebaseDB = FirebaseDB();
                      firebaseDB.uploadFile(_selectedFile!).then((value) {
                        bool success =  value['success'];
                        String message = value['message'];
                        fileUrl = value['data'];
                        if(success) {
                          _uploadProgress =  1.0;
                          _isUploading = false;
                          print("File uploaded successfully $fileUrl");
                          showInformativeDialog("File Uploaded", Colors.black54,
                              message, context);
                        }else{
                          _uploadProgress =  0.0;
                          _isUploading = false;
                          showInformativeDialog("File Not Uploaded", Colors.black54,
                              message, context);
                        }
                      }).onError((error, stackTrace) {
                        _uploadProgress =  0.0;
                        _isUploading = false;
                        showInformativeDialog("File Not Uploaded", Colors.black54,
                            "Error occured while uploading file", context);
                      }).timeout(Duration(seconds: 60), onTimeout: (){
                        _uploadProgress =  0.0;
                        _isUploading = false;
                        showInformativeDialog("File Not Uploaded", Colors.black54,
                            "Error occured while uploading file", context);
                      }).whenComplete(() {
                        setState(() {

                        });

                      });


                    },
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.red,
                      backgroundColor: Colors.green,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                      ),
                      elevation: 4.0, // Adjust the elevation as needed
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.v,
                          vertical: 12.0.v
                      ),
                    ),
                    child:  Container(
                      child: Text(
                        _uploadProgress ==1.0?"File uploaded":"Upload File",
                        style: TextStyle(fontSize: 20.0,color: Colors.white54),
                      ),
                    ),

                  ),

                  SizedBox(width: 10.h),
                  Container(
                    width: 130.h,
                    child: _isUploading ?LinearProgressIndicator(
                      // value: 1.0,
                      backgroundColor: appTheme.gray300,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green),
                    ):LinearProgressIndicator(
                      value: _uploadProgress,
                      backgroundColor: appTheme.gray300,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green),
                    )
                  ),

                  // horizontal progress bar
                  // Container(
                  //   child: LinearProgressIndicator(
                  //     value: 0.5,
                  //     backgroundColor: appTheme.gray300,
                  //     valueColor: AlwaysStoppedAnimation<Color>(
                  //         theme.colorScheme.primary),
                  //   ),
                  // ),
                ],
              ),

            ]
        )
    );
  }

  Widget _buildDefaultFile() {
    return Container(
      height: 150.v,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              Icons.file_copy,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Upload Mine Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the addNewPropertyMeetWithAAgentScreen when the action is triggered.
  onTapNext(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addNewPropertyMeetWithAAgentScreen);
  }

  onTapSelectLocation(BuildContext context) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: LocationPickerScreen(),
      withNavBar: false, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  addNewMine(BuildContext context) async {
    showProcessingDialog(context);
    FirebaseDB firebaseDB = FirebaseDB();
    print(
        "Mine Location ====================================== ${addressController.text}");
    await firebaseDB.addMine(
      context,
      addressController.text,
      areaController.text,
      gpsLatitude,
      gpsLongitude,
      claimantController.text,
      fileUrl,
    );
    // dismissDialog(context);
  }

  validateTextFields() {}
}
