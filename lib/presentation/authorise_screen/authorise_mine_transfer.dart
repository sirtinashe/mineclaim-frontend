import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/globals.dart';
import 'package:mineclaim/models/transfer_request.dart';
import 'package:mineclaim/presentation/authorise_screen/widgets/addnewpropertydetails_item_widget.dart';
import 'package:mineclaim/widgets/custom_elevated_button.dart';
import 'package:mineclaim/widgets/custom_icon_button.dart';
import 'package:mineclaim/widgets/custom_outlined_button.dart';
import 'package:mineclaim/widgets/dialogs.dart';

import '../../apis/api_calls.dart';
import '../../apis/firebase_db.dart';
import '../../models/mine.dart';
import '../../models/requests.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class AuthoriseMineTransferScreen extends StatefulWidget {
  AuthoriseMineTransferScreen({Key? key, required this.requestData, required this.mineData}) : super(key: key);

  final TransferRequests requestData ;
  final Mine mineData ;

  @override
  State<AuthoriseMineTransferScreen> createState() => _AuthoriseMineTransferScreenState();
}

class _AuthoriseMineTransferScreenState extends State<AuthoriseMineTransferScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var mineData =  MineclaimApi(context).getMineById(widget.requestData.mineId, widget.requestData.transferredBy);
    // mine =  mineData['data'];

  }


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
            widget.requestData.requestType,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            width: double.maxFinite,
            // padding: EdgeInsets.only(top: 24.v),
            child: ListView(children: [
              // SizedBox(height: 9.v),
              Container(
                  margin: EdgeInsets.only(bottom: 5.v),
                  padding: EdgeInsets.only(left: 16.h,right: 16.h,top: 5.v),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(

                          child: ListTile(


                            // contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                            dense:true,
                            visualDensity: VisualDensity(
                              vertical: -4,

                            ),
                            iconColor: widget.requestData.requestStatus != "Declined" ? Colors.green : Colors.red,
                            tileColor: Colors.grey.withOpacity(0.2),
                            leading: Icon(Icons.info),
                            title:  Text("${widget.requestData.requestType}",
                              style: TextStyle(
                                color: Colors.black54,
                                // fontWeight: FontWeight.w700
                              ),
                            ),
                            subtitle: Text(
                              widget.requestData.requestStatus,
                              style: TextStyle(
                                color: Colors.black54,
                                // fontWeight: FontWeight.w700
                              ),
                            ),
                            style: ListTileStyle.drawer,

                          ),
                        ),

                        SizedBox(height: 13.v),
                        _buildImg(context),
                        SizedBox(height: 13.v),
                        Padding(
                          padding:  EdgeInsets.only(
                              left: 10.h,
                              bottom: 10.h
                          ),
                          child: Text("Request Details",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        Divider(
                          indent: 8.h,
                          endIndent: 8.h,
                          thickness: 2.h,
                        ),
                        // SizedBox(height: 17.v),
                        _buildMightyCincoFamily(context),
                        SizedBox(
                          height: 10.v,
                        ),

                        Padding(
                          padding:  EdgeInsets.only(
                              left: 10.h,
                              bottom: 10.h
                          ),
                          child: Text("Mine Details",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                        Divider(
                          indent: 8.h,
                          endIndent: 8.h,
                          thickness: 2.h,
                        ),
                        _buildMineDetails(context),

                      ]
                  )
              )
            ])),
        bottomNavigationBar: widget.requestData.requestStatus =="Pending" ?_buildBTN(context): null
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64.h,

      centerTitle: true,
      title: AppbarSubtitleTwo(text: "Confirm Request"),
      // styleType: Style.bgFill
    );
  }

  /// Section Widget
  Widget _buildImg(BuildContext context) {
    return Container(
        height: 180.v,
        width: 327.h,

        margin: EdgeInsets.only(left: 8.h),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10.h),
          // color: Colors.red,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0), // Should match the above radius
          child: Image.network(
            widget.mineData.documentUrl,
            // width: 100.0,
            // height: 100.0,
            fit: BoxFit.cover,
          ),
        )
    );
  }

  /// Section Widget
  Widget _buildMightyCincoFamily(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child:Card(
        // elevation: 2.0,
        // borderRadius: BorderRadius.circular(10.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              ListTile(
                visualDensity: VisualDensity(
                  vertical: -4,
                ),

                // textColor: Colors.black54,
                tileColor: Colors.white54,
                leading: const Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
                title: const Text(
                  'Mine Owner',
                  // textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                // trailing: const Icon(Icons.req),
                subtitle:  Text(
                    widget.mineData.mineOwner,
                    style: TextStyle(
                      color: Colors.black54,
                    )
                ),
                selected: true,
                onTap: () {

                },
              ),
              // SizedBox(
              //   height: 3.v,
              // ),

              Padding(
                padding: EdgeInsets.only(
                  left: 4.h,
                  right: 4.h,
                ),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity: VisualDensity(
                        vertical: -4,
                      ),
                      // textColor: Colors.black54,
                      tileColor: Colors.white54,
                      leading: const Icon(
                        Icons.person,
                        color: Colors.black54,
                      ),
                      title: const Text(
                        'New owner: ',
                        // textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      // trailing: const Icon(Icons.req),
                      subtitle: Text(
                          widget.requestData.newMineOwner,
                          style: TextStyle(
                            color: Colors.black54,
                          )
                      ),
                      selected: true,
                      onTap: () {

                      },
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  /// Section Widget
  Widget _buildMineDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
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
                    widget.requestData.mineId,
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
                      widget.mineData.mineLocation,
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
                    Icons.area_chart,
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
                      widget.mineData.area,
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
          onPressed: () async {
            bool approve = await showActionDialog(widget.requestData.requestType, Colors.black54, "Are you sure you want to approve ${widget.requestData.requestType}", context);
            // Button action goes here
            if(approve){
              _verifyMineTransfer();
            }else{
              await dismissDialog(context);
            }
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

  _verifyMineTransfer() async {

    FirebaseDB firebaseDB = FirebaseDB();
    // print("Mine ID: ${widget.requestData.data['mineId']}");
    showProcessingDialog(context);
    // bool updated = await firebaseDB.transferMine(context, widget.requestData.mineId, widget.requestData.newMineOwner);
    await firebaseDB.verifyMineTransfer(context, widget.requestData.mineId);


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
