import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:mineclaim/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:mineclaim/widgets/app_bar/custom_app_bar.dart';
import 'package:mineclaim/widgets/custom_checkbox_button.dart';

// ignore_for_file: must_be_immutable
class PastToursScreen extends StatelessWidget {
  PastToursScreen({Key? key}) : super(key: key);

  bool complete = false;
  // Column(children: [
  // _buildOne(context),
  // SizedBox(height: 24.v),
  // // _buildTwo3(context)
  // ]
  // )
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: Container(
                    margin: EdgeInsets.only(bottom: 20.v),

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
            )
        )
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 60.h,
        centerTitle: true,
        title: AppbarSubtitleTwo(text: "Mine Collection"),
        styleType: Style.bgFill
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

  /// Section Widget
  Widget _buildTwo3(BuildContext context) {
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
              Text("Mon, Apr 4, 10:00 AM to 10:45 AM",
                  style: theme.textTheme.titleSmall),
              SizedBox(height: 4.v),
              CustomCheckboxButton(
                  text: "Complete",
                  value: complete,
                  textStyle: CustomTextStyles.labelLargeOnErrorSemiBold,
                  onChange: (value) {
                    complete = value;
                  }),
              SizedBox(height: 12.v),
              Container(
                  width: 264.h,
                  margin: EdgeInsets.only(right: 30.h),
                  child: Text(
                      "You can request another tour anytime, if you have questions please contact your agent",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.labelLargePrimaryContainer
                          .copyWith(height: 1.50))),
              SizedBox(height: 13.v),
              CustomImageView(
                  imagePath: ImageConstant.imgRectangle4259180x295,
                  height: 180.v,
                  width: 295.h,
                  radius: BorderRadius.circular(5.h)),
              SizedBox(height: 13.v),
              _buildTwo(context,
                  title: "Golden Meadows",
                  locationText: "St. Celina, Delaware 10299",
                  price: "Price",
                  priceText: "436")
            ]));
  }

  /// Common widget
  Widget _buildTwo(
      BuildContext context, {
        required String title,
        required String locationText,
        required String price,
        required String priceText,
      }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(bottom: 3.v),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: CustomTextStyles.titleMedium16
                    .copyWith(color: theme.colorScheme.primaryContainer)),
            SizedBox(height: 10.v),
            Row(children: [
              CustomImageView(
                  imagePath: ImageConstant.imgIconMapPin,
                  height: 14.adaptSize,
                  width: 14.adaptSize,
                  margin: EdgeInsets.only(bottom: 2.v)),
              Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(locationText,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: appTheme.blueGray500)))
            ])
          ])),
      Padding(
          padding: EdgeInsets.only(top: 3.v),
          child: Column(children: [
            Align(
                alignment: Alignment.centerRight,
                child: Text(price,
                    style: theme.textTheme.bodySmall!
                        .copyWith(color: appTheme.blueGray500))),
            SizedBox(height: 7.v),
            Text(priceText,
                style: CustomTextStyles.titleMediumPrimary_1
                    .copyWith(color: theme.colorScheme.primary))
          ]))
    ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
