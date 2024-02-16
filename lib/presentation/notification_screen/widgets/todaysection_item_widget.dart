import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class TodaysectionItemWidget extends StatelessWidget {
  const TodaysectionItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 18.v),
          child: CustomIconButton(
            height: 44.adaptSize,
            width: 44.adaptSize,
            padding: EdgeInsets.all(10.h),
            decoration: IconButtonStyleHelper.fillGray,
            child: CustomImageView(
              imagePath: ImageConstant.img1,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You received a mine",
              style: CustomTextStyles.titleSmallBold,
            ),
            SizedBox(height: 4.v),
            SizedBox(
              width: 210.h,
              child: Text(
                "Mine URYE277482MD was transferred to your wallet. Please check it out",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall!.copyWith(
                  height: 1.50,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 3.v,
            bottom: 16.v,
          ),
          child: Column(
            children: [
              Text(
                "1m ago",
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(height: 17.v),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 8.adaptSize,
                  width: 8.adaptSize,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(
                      4.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
