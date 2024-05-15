import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mineclaim/apis/api_calls.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/globals.dart';
import 'package:mineclaim/presentation/mine_gallery_screen/mine_gallery_screen.dart';
import 'package:mineclaim/presentation/my_home_empty_screen/empty_mines.dart';

import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_checkbox_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../apis/firebase_db.dart';
import '../../models/mine.dart';
import '../../widgets/dialogs.dart';
import '../add_new_mine_screen/add_new_mine_screen.dart';
import '../documents_picker/documents_picker.dart';

// ignore_for_file: must_be_immutable
class OwnedMines extends StatefulWidget {
  OwnedMines({Key? key}) : super(key: key);

  @override
  State<OwnedMines> createState() => _OwnedMinesState();
}

class _OwnedMinesState extends State<OwnedMines> with TickerProviderStateMixin{
  bool complete = false;

  // Column(children: [
  bool minesAvailable = false ;
  late TabController tabviewController;
  
  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: PrimaryColors().appDarkBlue,
          title: Text(
            "Claimed Mines",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
actions: [
            PopupMenuButton(
              itemBuilder: (ctx) => [
                _buildPopupMenuItem('Coming Soon'),

              ],
            )
          ],

          // bottom: _buildTabview(context),

        ),
        body: MineGallery(),


        floatingActionButton: SpeedDial(
          backgroundColor: Colors.white,
          icon: Icons.add,
          children: [
            SpeedDialChild(
                child: Icon(Icons.crop_landscape),
              label: "Claim mine",
              onTap: () async {
                String? mineId = await claimMineDialog(context);
                if (mineId != null) {
                  // Perform your logic with the mineId
                  // showProcessingDialog(context);
                  final mineData = await MineclaimApi(context).getMineById(mineId, '');
                  print("Data ${mineData}");
                  // dismissDialog(context);
                  if (!mineData['success']){
                    showInformativeDialog("Mine Information", Colors.black45, mineData['message'], context);
                  }else{
                    showProcessingDialog(context);
                    FirebaseDB firebaseDB = FirebaseDB();
                    Mine mine =  mineData['data'];
                    if(mine.mineOwner == globalUuid){
                      firebaseDB.addClaimedMines(context, mine);
                    }else{
                      // dismissDialog(context);
                      // check to see if the mine exist in firebase
                      bool isMineExist = await firebaseDB.checkMineExistence(mineId);
                      showInformativeDialog("Mine Information", Colors.black45, "You are not the owner of this mine , mine belongs to ${mine.mineOwner}", context);
                      print("Mine Exist $isMineExist");
                      if(isMineExist){
                        // showInformativeDialog("Mine Information", Colors.black45, "Mine already exist in your collection", context);
                        // delete the mine from firebase
                        bool isDeleted = firebaseDB.deleteMine(context ,mineId);

                      }


                    }

                  }

                  // print("Mine Id ${mineId}");

                }
              }
            ),
            SpeedDialChild(
                child: Icon(Icons.add),
              onTap: (){
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AddNewMineScreen(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              label:  "Add Mine"
            ),
          ],
        )
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 60.h,


        centerTitle: true,
        title: AppbarSubtitleTwo(text: "Your collection"),
        actions: [

          Container(
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black54,
                ),
                onPressed: (){},
              )
          ),
          PopupMenuButton(
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
            margin: EdgeInsets.only(bottom: 20.v,top: 20.v),

            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: ListView.builder(
              // padding:  EdgeInsets.only(bottom: 20.v),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: _buildOne(context),
                  );
                }
            )
        )
    );
  }

  Widget tabView(BuildContext context){
    return Flexible(
        // height: 600.v,
        child: TabBarView(
            controller: tabviewController,
            children: [
              MineGallery(),
              MineGallery(),
              // BookingOngoingPage()
            ]
        )
    );
  }

  /// Section Widget
  Widget _buildOne(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 13.v),
        decoration: AppDecoration.outlineGray300
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 3.v),
              Text("QRT24009565Q",
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
                    child: Text("136 sqm",
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
                  child: Text("Price:",
                      style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.black54,
                          fontSize: 12
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text("\$200",
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
                  child: Text("Registration Status:",
                      style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.black54,
                          fontSize: 12
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text("Verified",
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
                    child: Text("123 Ringoville Chegutu",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                )

              ]),
              SizedBox(height: 13.v),
              Container(
                  width: 264.h,
                  margin: EdgeInsets.only(right: 30.h),
                  child: Text(
                      "This were is were any description will come.This were is were any description will come",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.labelLargePrimaryContainer
                          .copyWith(height: 1.50))),
              // SizedBox(height: 13.v),
              CustomImageView(
                  imagePath: "https://www.researchgate.net/publication/352676417/figure/fig1/AS:1037724651909121@1624424245893/Satellite-location-for-Mimosa-Mine-Source-Google-maps.png",
                  height: 180.v,
                  width: 295.h,
                  radius: BorderRadius.circular(5.h),
                  fit: BoxFit.fill,
              ),
              // SizedBox(height: 40.v),
            ]
        )
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }


}
