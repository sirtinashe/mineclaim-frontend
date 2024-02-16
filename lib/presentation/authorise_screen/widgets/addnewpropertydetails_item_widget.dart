import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';

// ignore: must_be_immutable
class AddnewpropertydetailsItemWidget extends StatelessWidget {
  const AddnewpropertydetailsItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      width: 101.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Estimate price",
            style: theme.textTheme.labelMedium,
          ),
          SizedBox(height: 4.v),
          Text(
            "4,200.00",
            style: CustomTextStyles.titleSmallBold,
          ),
          SizedBox(height: 3.v),
          Container(
            width: 36.h,
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 4.v,
            ),
            decoration: AppDecoration.fillRed.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Text(
              "-4%",
              style: CustomTextStyles.labelMediumSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
