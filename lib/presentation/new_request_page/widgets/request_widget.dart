import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/models/request_types.dart';
import 'package:mineclaim/presentation/profile_authorisation_screen/profile_autorisation_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../models/requests.dart';

import '../../authorise_screen/authorise_screen.dart';

// ignore: must_be_immutable
class RequestWidget extends StatelessWidget {
  RequestWidget({
    Key? key,
    required this.requestData,
  }) : super(
          key: key,
        );


  final Requests requestData ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAuthorise(context,requestData.requestTypes);
      },
      child: Container(

        child: Row(
          children: [
            CustomImageView(
              imagePath: requestData.imagePath,
              height: 109.v,
              width: 102.h,
              radius: BorderRadius.horizontal(
                left: Radius.circular(10.h),
              ),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.h,
                top: 15.v,
                bottom: 12.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    requestData.requestType,
                    style: CustomTextStyles.titleMediumBold,
                  ),

                  SizedBox(height: 3.v),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Container(
                      width: 180.h,
                      child: Text(

                        "Requester: ${requestData.requester}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1, // Optional: Limit to a single line
                        // style: CustomTextStyles.titleSmallBluegray500Medium
                        style: TextStyle(

                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Row(
                      children: [
                        Text(
                            "Status: ",
                            style: theme.textTheme.titleSmall!.copyWith(
                              // color: Colors.green,
                              fontWeight: FontWeight.w500,
                            )
                        ),
                        Text(
                            requestData.requestStatus ,
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: requestData.requestStatus == "Declined" ? Colors.red : Colors.green,
                              fontWeight: FontWeight.w700,
                            )
                        ),
                      ],
                    )
                  ),
                 Container(
                   child: requestData.requestStatus == "Pending" ? OutlinedButton(
                       style: ButtonStyle(
                         foregroundColor:   MaterialStatePropertyAll(Colors.black54),
                           padding: MaterialStatePropertyAll(
                               EdgeInsets.all(10.v),

                           )
                       ),
                       onPressed: (){
                         onTapAuthorise(context,requestData.requestTypes);
                       },
                       child: Text(
                           "Attent to Request",
                       )
                   ): Container(),
                 )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  onTapAuthorise(BuildContext context,RequestTypes requestTypes) {
    switch(requestTypes){
      case RequestTypes.TRANSFER_OWNERSHIP:
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: AuthoriseScreen(
            requestData: requestData,
          ),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
        break;
      case RequestTypes.VERIFY_PROFILE:
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ProfileAuthorisationScreen(
            requestData: requestData,
          ),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
        break ;
    }
  }
}
