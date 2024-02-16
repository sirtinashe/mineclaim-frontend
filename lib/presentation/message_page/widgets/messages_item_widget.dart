import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';

// ignore: must_be_immutable
class MessagesItemWidget extends StatelessWidget {
  MessagesItemWidget({
    Key? key,
    this.onTapMsg,
  }) : super(
          key: key,
        );

  VoidCallback? onTapMsg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapMsg!.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 48.adaptSize,
            width: 48.adaptSize,
            margin: EdgeInsets.only(bottom: 2.v),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgImg48x48,
                  height: 48.adaptSize,
                  width: 48.adaptSize,
                  radius: BorderRadius.circular(
                    24.h,
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onError,
                      borderRadius: BorderRadius.circular(
                        6.h,
                      ),
                      border: Border.all(
                        color: appTheme.gray50,
                        width: 1.h,
                        strokeAlign: strokeAlignOutside,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wade Warren",
                  style: CustomTextStyles.titleMediumBold,
                ),
                SizedBox(height: 9.v),
                Text(
                  "Oh hello Willam...",
                  style: CustomTextStyles.titleSmallBluegray500Medium,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 30.v),
            child: Text(
              "23:15",
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
