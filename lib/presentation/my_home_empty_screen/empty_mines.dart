import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class EmptyMinesScreen extends StatelessWidget {
  EmptyMinesScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 7.v),
                      CustomImageView(
                          imagePath: ImageConstant.imgFrame,
                          height: 255.adaptSize,
                          width: 255.adaptSize),
                      SizedBox(height: 63.v),
                      Text("Ready to buy your mine?",
                          style: theme.textTheme.titleLarge),
                      SizedBox(height: 6.v),
                      SizedBox(
                          width: 324.h,
                          child: Text(
                              "Relax is making it simpler to your home and move forward.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(height: 1.50))),
                      SizedBox(height: 22.v),
                      CustomElevatedButton(
                          height: 45.v,
                          width: 155.h,
                          text: "Buy a mine",
                          onPressed: () {
                            onTapAddProprty(context);
                          })
                    ])),

        )
    );
  }
  /// Navigates to the homeContainerScreen when the action is triggered.
  onTapAddProprty(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
  }
}
