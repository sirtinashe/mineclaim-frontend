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

import '../../models/mine.dart';
import '../../widgets/dialogs.dart';
import '../location_screens/location_picker_screen.dart';
import 'package:mineclaim/apis/firebase_db.dart';

// ignore_for_file: must_be_immutable
class TransferMineScreen extends StatefulWidget {
  TransferMineScreen({Key? key, required this.mine}) : super(key: key);
  final Mine mine;

  @override
  State<TransferMineScreen> createState() => _TransferMineScreenState();
}

class _TransferMineScreenState extends State<TransferMineScreen> {


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

  TextEditingController receiverController = TextEditingController();

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
            "Transfer Mine",
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
                              SizedBox(height: 150.v),
                              _buildMineDetails(context),
                              SizedBox(height: 20.v),
                              _ReceiverField(context),
                              SizedBox(height: 5.v),
                              // _addFile(context),
                            ]
                        )
                    )
                )
            )
        ),
        bottomNavigationBar: _buildBtn(context));
  }

  /// Section Widget
  Widget _buildMineDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.h),
      child:Card(
        // elevation: 2.0,
        // borderRadius: BorderRadius.circular(10.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [


              // SizedBox(
              //   height: 3.v,
              // ),
              ListTile(
                visualDensity: VisualDensity(
                  vertical: -4,
                ),
                // textColor: Colors.black54,
                tileColor: Colors.white54,
                leading: const Icon(
                  Icons.landscape_sharp,
                  color: Colors.black54,
                ),
                title: const Text(
                  'Mine ID:',
                  // textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                // trailing: const Icon(Icons.req),
                subtitle: Text(
                    widget.mine.mineId,
                    style: TextStyle(
                      color: Colors.black54,
                    )
                ),
                selected: true,
                onTap: () {

                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.h,
                  right: 4.h,
                ),
                child: ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  // textColor: Colors.black54,
                  tileColor: Colors.white54,
                  leading: const Icon(
                    Icons.location_on_rounded,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    'Mine Location',
                    // textScaleFactor: 1.5,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  // trailing: const Icon(Icons.req),
                  subtitle: Text(
                      widget.mine.mineId,
                      style: TextStyle(
                        color: Colors.black54,
                      )
                  ),
                  selected: true,
                  onTap: () {

                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.h,
                  right: 4.h,
                ),
                child: ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  // textColor: Colors.black54,
                  tileColor: Colors.white54,
                  leading: const Icon(
                    Icons.landslide_outlined,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    'Area',
                    // textScaleFactor: 1.5,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  // trailing: const Icon(Icons.req),
                  subtitle: Text(
                      widget.mine.area,
                      style: TextStyle(
                        color: Colors.black54,
                      )
                  ),
                  selected: true,
                  onTap: () {

                  },
                ),
              ),
            ],
          )
      ),
    );
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


  



  /// Section Widget
  Widget _ReceiverField(BuildContext context) {
    return CustomTextFormField(
      controller: receiverController,
      hintText: "Enter Receiver ID",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.text,
      focusNode: areaFocusNode,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty ) {
          return "Provide receiver ID";
        }
      },
    );
  }


  /// Section Widget
  Widget _buildNext(BuildContext context) {
    return CustomElevatedButton(
        text: "Transfer Mine",
        onPressed: () async {
          // onTapNext(context);
          // addNewMine(context);
          // addNewMine(context);
          if (validateInputs()) {
            bool confirmation = await showActionDialog("Add Mine",
                Colors.black54, "Are you sure you want to add a mine", context);
            if (confirmation) {
              await transferMine(context);
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
      receiverController.text,
      gpsLatitude,
      gpsLongitude,
      claimantController.text,
      fileUrl,
    );
    // dismissDialog(context);
  }

  transferMine(BuildContext context) async {
    showProcessingDialog(context);
    FirebaseDB firebaseDB = FirebaseDB();
    print(
        "Mine Location ====================================== ${addressController.text}");

    await firebaseDB.transferMine(
      context,
      widget.mine.mineId,
      receiverController.text

    );


    // dismissDialog(context);
  }

  validateTextFields() {}
}
