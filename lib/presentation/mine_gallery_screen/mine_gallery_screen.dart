import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/globals.dart';
import 'package:mineclaim/presentation/confirm_request_screen/confirm_request_screen.dart';
import 'package:mineclaim/presentation/mine_gallery_screen/claim_mine.dart';
import 'package:mineclaim/presentation/my_home_empty_screen/empty_mines.dart';
import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_checkbox_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../helper.dart';
import '../../models/mine.dart';
import '../../widgets/dialogs.dart';
import '../add_new_mine_screen/add_new_mine_screen.dart';
import '../documents_picker/documents_picker.dart';

// import api calls
import '../../apis/api_calls.dart';
import '../transfer_mine/transfer_mine_screen.dart';

// ignore_for_file: must_be_immutable
class MineGallery extends StatefulWidget {
  MineGallery({Key? key}) : super(key: key);

  @override
  State<MineGallery> createState() => _MineGalleryState();
}

class _MineGalleryState extends State<MineGallery> {
  bool complete = false;
  late Future<Map<String,dynamic>> futureMines;

  // Column(children: [
  bool minesAvailable = false ;
  String message = "No mines available";
  // Stream<QuerySnapshot>? stream;

  Future<Map<String ,dynamic>>_getMines() async {

    return await MineclaimApi(context).getAllMines();
    }
  @override
  void initState() {
    super.initState();
    futureMines = _getMines();
    // stream = FirebaseFirestore.instance
    //     .collection('claimed_by_$globalUuid')
    //     .snapshots();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7EEFA),
      // appBar: _buildAppBar(context),
      body: !minesAvailable ? _mineAvailable(context) : EmptyMinesScreen(),

    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 60.h,


      centerTitle: true,
      title: AppbarSubtitleTwo(
          text: "Mine Gallery"
      ),
      actions: [
        Container(
            child: IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: (){},
            )
        ),
        PopupMenuButton(
          // color: Colors.white,
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          itemBuilder: (ctx) => [
            _buildPopupMenuItem('Search'),
            _buildPopupMenuItem('Upload'),
            _buildPopupMenuItem('Copy'),
            _buildPopupMenuItem('Exit'),
          ],
        )

      ],
      // styleType: Style.bgFill
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      String title) {
    return PopupMenuItem(
      child:  Text(title),
    );
  }

  Widget _mineAvailable(context){
    return SizedBox(
        width: SizeUtils.width,
        child: Container(
          color: Color(0xFFE7EEFA),
            margin: EdgeInsets.only(bottom: 20.v,top: 10.v),

            padding: EdgeInsets.symmetric(horizontal: 24.h),
            // child: Center(child: Text("Mines available",style: TextStyle(fontSize: 20.0,color: Colors.black),))
            // create child future builder to fetch mines
            child: FutureBuilder<Map<String ,dynamic>>(
                future: futureMines,
                builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print(snapshot.data);
                List<Mine> mines = snapshot.data!['data'] ?? [];


                if (mines.length == 0) {
                  minesAvailable = false;
                  return EmptyMinesScreen();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("An error occurred while fetching mines"),
                  );
                } else {
                  return ListView.builder(
                      // padding:  EdgeInsets.only(bottom: 20.v),
                      itemCount: mines.length,
                      itemBuilder: (BuildContext context, int index){
                        // Mine mine  =  RequestSerializer.serializeClaimedMines(documents[index].data());
                        
                        return Card(
                          child: Padding(
                            // padding: const EdgeInsets.all(8.0),
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: _buildOne(context,mines[index] ),
                          ),
                        );
                      }
                  );
                }

              }
            }
            ),
        )
    );
  }

  /// Section Widget
  Widget _buildOne(BuildContext context , Mine mine) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 13.v),
        // decoration: AppDecoration.outlineGray300
        //     .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 3.v),
              Text(mine.mineId,
                  style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.black54
                  )
              ),
              SizedBox(height: 3.v),
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text("Mine Size:",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text("${mine.area} sqm",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                )
              ]),

              Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text("Claimant:",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(mine.claimant,
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                )
              ]),

              Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text("Owner address:",

                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 4.h),

                    child: Container(
                      width: 100.h,
                      child: Text(mine.mineOwner,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.black54,
                              fontSize: 12
                          )
                      ),
                    )
                )

              ]),
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text("Registration Status:",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(mine.verified ,
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.green,
                            fontSize: 12
                        )
                    )
                )

              ]),
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text("Location: ",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(mine.mineLocation,
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                )

              ]),


              CustomImageView(
                imagePath: mine.documentUrl,
                height: 180.v,
                width: 295.h,
                radius: BorderRadius.circular(5.h),
                fit: BoxFit.fill,
              ),
              // Image.network(
              //   mine.documentUrl,
              // ),

              SizedBox(height: 13.v),
              Container(
                child: mine.mineOwner == globalUuid ?ElevatedButton(
                  onPressed: () async {
                    // buildDialog(context);

                    // navigate to ConfirmRequestScreen
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: TransferMineScreen(
                        mine: mine,
                      ),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );

                    // Button action goes here
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.red,
                    backgroundColor: Color(0xFF152A47),

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
                    "Transfer",
                    style: TextStyle(fontSize: 20.0,color: Colors.white),
                  ),
                ):Container(),
              )
            ]
        )
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
