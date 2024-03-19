import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/presentation/confirm_request_screen/confirm_request_screen.dart';
import 'package:mineclaim/presentation/mine_gallery_screen/claim_mine.dart';
import 'package:mineclaim/presentation/my_home_empty_screen/empty_mines.dart';
import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_checkbox_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../widgets/dialogs.dart';
import '../add_new_mine_screen/add_new_mine_screen.dart';
import '../documents_picker/documents_picker.dart';

// ignore_for_file: must_be_immutable
class MineGallery extends StatelessWidget {
  MineGallery({Key? key}) : super(key: key);

  bool complete = false;
  // Column(children: [
  // _buildOne(context),
  // SizedBox(height: 24.v),
  // // _buildTwo3(context)
  // ]
  // )
  bool minesAvailable = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7EEFA),
      // appBar: _buildAppBar(context),
      body: !minesAvailable ? _mineAvailable(context) : EmptyMinesScreen(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add,color: Color(0xFF152A47),),
        backgroundColor: Color(0xFFE7EEFA),
        onPressed: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: AddNewMineScreen(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
          // Navigator.pushNamed(context, AppRoutes.addNewPropertyAddressScreen);
        },
      ),
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

        // Container(
        //     child: IconButton(
        //       icon: Icon(
        //         Icons.search,
        //         color: Colors.black54,
        //       ),
        //       onPressed: (){},
        //     )
        // ),
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
            child: ListView.builder(
              // padding:  EdgeInsets.only(bottom: 20.v),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index){
                  return Card(
                    child: Padding(
                      // padding: const EdgeInsets.all(8.0),
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: _buildOne(context),
                    ),
                  );
                }
            )
        )
    );
  }
  /// Section Widget
  Widget _buildOne(BuildContext context) {
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
                    child: Text("Owner address:",
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: 12
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text("84476d3t2t36",
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

              // SizedBox(height: 13.v),
              // Container(
              //     width: 264.h,
              //     margin: EdgeInsets.only(right: 30.h),
              //     child: Text(
              //         "This were is were any description will come.This were is were any description will come",
              //         maxLines: 2,
              //         overflow: TextOverflow.ellipsis,
              //         style: CustomTextStyles.labelLargePrimaryContainer
              //             .copyWith(height: 1.50))),
              // SizedBox(height: 13.v),
              CustomImageView(
                imagePath: "https://www.researchgate.net/publication/352676417/figure/fig1/AS:1037724651909121@1624424245893/Satellite-location-for-Mimosa-Mine-Source-Google-maps.png",
                height: 180.v,
                width: 295.h,
                radius: BorderRadius.circular(5.h),
                fit: BoxFit.fill,
              ),

              SizedBox(height: 13.v),
              ElevatedButton(
                onPressed: () async {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: ClaimMineDetails(),
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
                  "Claim mine",
                  style: TextStyle(fontSize: 20.0,color: Colors.white),
                ),
              ),
            ]
        )
    );
  }




  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
