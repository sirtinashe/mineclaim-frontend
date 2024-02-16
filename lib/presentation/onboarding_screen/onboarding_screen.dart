import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/widgets/custom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: appTheme.gray300,
            body: Container(
                width: SizeUtils.width,
                height: SizeUtils.height,
                decoration: BoxDecoration(
                    color: appTheme.gray300,
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgGroup267),
                        fit: BoxFit.cover)),
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 26.h, vertical: 40.v),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Spacer(),
                          Container(
                              decoration: AppDecoration.outlineBlackF,
                              child: Text("Enjoy the beautiful world",
                                  style:
                                      CustomTextStyles.headlineSmallGray300)),
                          SizedBox(height: 17.v),
                          SizedBox(
                              width: 318.h,
                              child: Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.titleSmallGray300
                                      .copyWith(height: 1.50))),
                          SizedBox(height: 29.v),
                          SizedBox(
                              height: 6.v,
                              child: AnimatedSmoothIndicator(
                                  activeIndex: 0,
                                  count: 2,
                                  effect: ScrollingDotsEffect(
                                      activeDotColor: Color(0X1212121D),
                                      dotHeight: 6.v)))
                        ]))),
            bottomNavigationBar: _buildGetStartedButton(context)));
  }

  /// Section Widget
  Widget _buildGetStartedButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Get Started",
        margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 58.v),
        onPressed: () {
          onTapGetStartedButton(context);
        });
  }

  /// Navigates to the signInScreen when the action is triggered.
  onTapGetStartedButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signInScreen);
  }
}
