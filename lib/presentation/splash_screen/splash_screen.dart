import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray900,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 1.v),
              CustomImageView(
                imagePath: ImageConstant.imgTelevision,
                height: 99.v,
                width: 90.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
