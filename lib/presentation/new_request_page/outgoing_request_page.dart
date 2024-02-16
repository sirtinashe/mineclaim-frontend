
import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';

import 'package:mineclaim/widgets/dialogs.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../confirm_request_screen/confirm_request_screen.dart';

class NewRequestPage extends StatefulWidget {
  NewRequestPage({Key? key}) : super(key: key);



  @override
  State<NewRequestPage> createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  // bool _download = true;

  final ValueNotifier<bool> _download = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _downloading =  ValueNotifier<bool>(false);
  final ValueNotifier<double> _progress = ValueNotifier(0.0);

  List<String> dropdownItemList = ["Profile verification", "Mine Transfer", "Prospecting Licence Approval"];
  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(

          title: Text(
            "Create new request",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 25.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 7.v),
                  // CustomImageView(
                  //     imagePath: "https://img.freepik.com/free-vector/online-concept-illustration_114360-2509.jpg",
                  //     height: 255.adaptSize,
                  //     width: 255.adaptSize
                  // ),
                  Text("Ready to make a new request?",
                      style: theme.textTheme.titleLarge),
                  SizedBox(height: 6.v),
                  SizedBox(
                      width: 324.h,
                      child: Text(
                          "Select a request type from below",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge!
                              .copyWith(height: 1.50))),
                  SizedBox(height: 22.v),

                  CustomDropDown(
                      icon: Container(
                        padding: EdgeInsets.only(right: 20.h),
                        child: Icon(

                            Icons.arrow_drop_down,
                          size: 30,

                        ),
                      ),
                      hintText: "Select",
                      hintStyle: CustomTextStyles
                          .titleSmallBluegray500Medium,
                      items: dropdownItemList,
                      borderDecoration:
                      DropDownStyleHelper.fillGray,
                      fillColor: appTheme.gray300,
                      onChanged: (value) {
                        print("value $value");
                        dropdownValue = value;
                      }
                  ),
                  SizedBox(height: 63.v),

                  // SizedBox(height: 22.v),
                  CustomElevatedButton(
                      height: 45.v,
                      width: 155.h,
                      text: "Continue",
                      onPressed: () {
                        // onTapAddProprty(context);
                        onTapRequest(context,dropdownValue);
                      })
                ])),

    );
  }

  Widget _downloadIcon(BuildContext context,bool downloaded,bool downloading,double progressValue){
    if(downloaded && !downloading){
      return IconButton(
        color: Colors.green,

        onPressed: () {
          showInformativeDialog("File downloaded", Colors.black54, "Relax that was just a dummy download", context);
        },
        icon: Icon(
          Icons.cloud_done_outlined,
          size: 30,
        ),
      );
    }else if(downloading){
      return Container(
        child: _progress.value >0.005 ?Container(
          child: CircularProgressIndicator(
            value: _progress.value,
            color: Colors.green,

          ),
        ):Container(
          child: CircularProgressIndicator(
            // value: _progress.value,
            color: Colors.red,

          ),
        ),
      );
    }
    return IconButton(
      color: Colors.green,

      onPressed: () async {
        _downloading.value = true ;
        await _simulateDownload().whenComplete(() {
          _download.value = true ;
          _downloading.value = false ;
          final snackBar = SnackBar(
            content: Text('File downloaded'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });

      },
      icon: Icon(
        Icons.cloud_download_outlined,
        size: 30,
      ),
    );
  }

  Future _simulateDownload() async{
    await Future.delayed(Duration(seconds: 1), () => _progress.value = 0.2);
    await Future.delayed(Duration(seconds: 2), () => _progress.value = 0.4);
    await Future.delayed(Duration(seconds: 1), () => _progress.value = 0.6);
    await Future.delayed(Duration(seconds: 3), () => _progress.value = 0.8);
    await Future.delayed(Duration(seconds: 1), () => _progress.value = 1);
  }







  /// Section Widget
  Widget _buildContactAgent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // CustomElevatedButton(text: "Contact Agent"),
        ElevatedButton(
          onPressed: () {
            // Button action goes here
          },
          style: ElevatedButton.styleFrom(

            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
            ),
            elevation: 4.0, // Adjust the elevation as needed
            padding: EdgeInsets.symmetric(
                horizontal: 40.0.v,
                vertical: 22.0.v
            ), // Adjust the padding as needed
          ),
          child: Text(
            'Decline',
            style: TextStyle(fontSize: 20.0,color: Colors.red),
          ),
        ),
        SizedBox(width: 10,),
        ElevatedButton(
          onPressed: () {
            showActionDialog("Transfer mine", Colors.black54, "Are you sure you want to transfer mine", context);
            // Button action goes here
          },
          style: ElevatedButton.styleFrom(
            // backgroundColor: Colors.red,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
            ),
            elevation: 4.0, // Adjust the elevation as needed
            padding: EdgeInsets.symmetric(
                horizontal: 40.0.v,
                vertical: 22.0.v
            ),
          ),
          child: Text(
            'Approve',
            style: TextStyle(fontSize: 20.0,color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildBTN(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 24.v),
        decoration: AppDecoration.outlineBlueGrayF,
        child: _buildContactAgent(context));
  }

  onTapRequest(BuildContext context,String dropdownValue) {
    if(dropdownValue == "Profile verification"){
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: ConfirmRequestScreen(),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }else if(dropdownValue == "Mine Transfer"){
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: ConfirmRequestScreen(),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }else if(dropdownValue == "Prospecting Licence Approval"){
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: ConfirmRequestScreen(),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
    else{
      showInformativeDialog("Select a request type", Colors.black54, "Please select a request type from the dropdown", context);
    }
  }


  /// Navigates back to the previous screen.
  onTapBtnArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  const MyAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 2, // Controls the shadow depth
      color: Color(0xFFE7EEFA),
      shadowColor: Colors.grey.withOpacity(0.5),
      child: AppBar(
        backgroundColor: Color(0xFFE7EEFA),
        centerTitle: true,

        title: title,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
