import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mineclaim/apis/api_calls.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/globals.dart';
import 'package:mineclaim/my_personal_mines/personal_mines_widget.dart';
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
import '../presentation/add_new_mine_screen/add_new_mine_screen.dart';
import '../presentation/transfer_mine/transfer_mine_screen.dart';


// ignore_for_file: must_be_immutable
class MyPersonalMines extends StatefulWidget {
  MyPersonalMines({Key? key}) : super(key: key);

  @override
  State<MyPersonalMines> createState() => _MyPersonalMinesState();
}

class _MyPersonalMinesState extends State<MyPersonalMines> with TickerProviderStateMixin{
  bool complete = false;

  // Column(children: [
  bool minesAvailable = false ;
  late TabController tabviewController;
  late Future<Map<String,dynamic>> futureMines;

  Future<Map<String ,dynamic>>_getMines() async {

    return await MineclaimApi(context).getMines(globalUuid);
  }

  @override
  void initState() {
    super.initState();
    futureMines = _getMines();
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
            "Owned Mines",
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
        body: SizedBox(
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
                              Mine mine = mines[index];
                              return Card(
                                child: Padding(
                                  // padding: const EdgeInsets.all(8.0),
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    // child: _buildOne(context,mines[index] ),
                                    child: Container(
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
                                              ElevatedButton(
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
                                              ),
                                            ]
                                        )
                                    )
                                ),
                              );
                            }
                        );
                      }

                    }
                  }
              ),
            )
        ),


        floatingActionButton: globalEmail == "ministry@gmail.com"?SpeedDial(
          backgroundColor: Colors.white,
          icon: Icons.add,
          children: [
            SpeedDialChild(
                child: Icon(Icons.refresh),
                label: "Refresh",
                onTap: () async {

                  futureMines = _getMines();
                  setState(() {

                  });
                }
            ),
            SpeedDialChild(
                child: Icon(Icons.add),
                onTap: (){
                  if (globalEmail != "ministry@gmail.com"){
                    showInformativeDialog("Message", Colors.black54, "You are not allowed to add a mine", context);
                  }else{
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: AddNewMineScreen(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );

                  }

                },
                label:  "Add Mine"
            ),
          ],
        ):SpeedDial(
          backgroundColor: Colors.white,
          icon: Icons.add,
          children: [
            SpeedDialChild(
                child: Icon(Icons.refresh),
                label: "Refresh",
                onTap: () async {

                  futureMines = _getMines();
                  setState(() {

                  });
                }
            )
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
