
import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/presentation/authorise_screen/widgets/addnewpropertydetails_item_widget.dart';
import 'package:mineclaim/widgets/custom_elevated_button.dart';
import 'package:mineclaim/widgets/custom_icon_button.dart';
import 'package:mineclaim/widgets/custom_outlined_button.dart';
import 'package:mineclaim/widgets/dialogs.dart';

import '../../models/requests.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class ProfileAuthorisationScreen extends StatefulWidget {
  ProfileAuthorisationScreen({Key? key, required this.requestData}) : super(key: key);

  final Requests requestData ;

  @override
  State<ProfileAuthorisationScreen> createState() => _ProfileAuthorisationScreenState();
}

class _ProfileAuthorisationScreenState extends State<ProfileAuthorisationScreen> {
  // bool _download = true;

  final ValueNotifier<bool> _download = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _downloading =  ValueNotifier<bool>(false);
  final ValueNotifier<double> _progress = ValueNotifier(0.0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(

          title: Text(
            'Profile Verification',
            style: TextStyle(
              color: Colors.black54,
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
                            iconColor: widget.requestData.requestStatus.toString() != "Declined" ? Colors.green : Colors.red,
                            tileColor: Colors.grey.withOpacity(0.2),
                            leading: Icon(Icons.info),
                            title:  Text("${widget.requestData.requestType.toString()}",
                              style: TextStyle(
                                color: Colors.black54,
                                // fontWeight: FontWeight.w700
                              ),
                            ),
                            subtitle: Text(
                              widget.requestData.requestStatus.toString(),
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
                          child: Text("Requester Details",
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
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.h,
                              right: 10.h
                          ),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(10.0),
                            child: ListTile(


                              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                              // dense:true,
                              // visualDensity: VisualDensity(
                              //   vertical: -4,
                              //
                              // ),

                              // tileColor: Colors.grey,
                              leading: Icon(Icons.file_copy,
                                color: Colors.black54,
                              ),
                              title:  Text("Prospecting Licence",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              trailing: ValueListenableBuilder<bool>(
                                valueListenable: _download,
                                builder: (context, _downloadValue, child) {
                                  // This builder will only get called when the _counter
                                  // is updated.
                                  return ValueListenableBuilder<bool>(
                                      valueListenable: _downloading,
                                      builder: (context , _downloadingValue,child){
                                        return ValueListenableBuilder<double>(
                                            valueListenable: _progress,
                                            builder: (context ,progressValue, child){
                                              return _downloadIcon(context, _downloadValue,_downloadingValue, progressValue);
                                            }
                                        );
                                      }
                                  );
                                },
                              ),
                              style: ListTileStyle.drawer,

                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7.v,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 10.h,
                                  right: 10.h
                          ),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(10.0),
                            child: ListTile(


                              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                              // dense:true,
                              // visualDensity: VisualDensity(
                              //   vertical: -4,
                              //
                              // ),

                              // tileColor: Colors.grey,
                              leading: Icon(Icons.picture_as_pdf,
                                color: Colors.red,
                              ),
                              title:  Text("ID Document",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              trailing: ValueListenableBuilder<bool>(
                                valueListenable: _download,
                                builder: (context, _downloadValue, child) {
                                  // This builder will only get called when the _counter
                                  // is updated.
                                  return ValueListenableBuilder<bool>(
                                      valueListenable: _downloading,
                                      builder: (context , _downloadingValue,child){
                                        return ValueListenableBuilder<double>(
                                            valueListenable: _progress,
                                            builder: (context ,progressValue, child){
                                              return _downloadIcon(context, _downloadValue,_downloadingValue, progressValue);
                                            }
                                        );
                                      }
                                  );
                                },
                              ),
                              style: ListTileStyle.drawer,

                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7.v,
                        )
                      ]
                  )
              )
            ])),
        bottomNavigationBar: widget.requestData.requestStatus.toString() =="Pending" ?_buildBTN(context): null
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
            widget.requestData.imagePath,
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
                  Icons.wallet,
                  color: Colors.black54,
                ),
                title: const Text(
                  'Requester ID',
                  // textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                // trailing: const Icon(Icons.req),
                subtitle:  Text(
                    widget.requestData.requester.toString(),
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
                        'Requester Name',
                        // textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      // trailing: const Icon(Icons.req),
                      subtitle: Text(
                          widget.requestData.data['requesterName'].toString(),
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
              ),
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
                        Icons.card_membership,
                        color: Colors.black54,
                      ),
                      title: const Text(
                        'Id Number',
                        // textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      // trailing: const Icon(Icons.req),
                      subtitle: Text(
                          widget.requestData.data['idNumber'].toString(),
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
                    Icons.card_membership,
                    color: Colors.black54,
                  ),
                  title: const Text(
                    'Phone Number',
                    // textScaleFactor: 1.5,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  // trailing: const Icon(Icons.req),
                  subtitle: Text(
                      widget.requestData.data['phoneNumber'].toString(),
                      style: TextStyle(
                        color: Colors.black54,
                      )
                  ),
                  selected: true,
                  onTap: () {

                  },
                ),
              )

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

  /// Common widget


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
