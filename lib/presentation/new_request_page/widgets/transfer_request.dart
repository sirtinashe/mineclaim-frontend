import 'package:flutter/material.dart';
import 'package:mineclaim/core/app_export.dart';
import 'package:mineclaim/models/request_types.dart';
import 'package:mineclaim/presentation/profile_authorisation_screen/profile_autorisation_screen.dart';
import 'package:mineclaim/widgets/dialogs.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../apis/api_calls.dart';
import '../../../models/mine.dart';
import '../../../models/requests.dart';

import '../../../models/transfer_request.dart';
import '../../authorise_screen/authorise_mine_transfer.dart';
import '../../authorise_screen/authorise_screen.dart';

// ignore: must_be_immutable
class TransferRequestWidget extends StatelessWidget {
  TransferRequestWidget({
    Key? key,
    required this.requestData,
  }) : super(
    key: key,
  );


  final TransferRequests requestData ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAuthorise(context,requestData.requestTypes);
      },
      child: Container(

        child: Row(
          children: [
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

                          "Requester: ${requestData.transferredBy}",
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



  onTapAuthorise(BuildContext context,RequestTypes requestTypes) async {
    print("Mine id ${requestData.mineId} and transferred , ${requestData.transferredBy}");
    Map<String ,dynamic> data = await MineclaimApi(context).getMineById(requestData.mineId, requestData.transferredBy);
    Mine mine =  data['data'];
    print("Mine data just ${mine.mineLocation}");
    //  print("Mine data just ${mine.mineLocation}");
    if( data['success']){
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: AuthoriseMineTransferScreen(
          requestData: requestData,
          mineData: data['data'],
        ),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    }
    // else{
    //   showInformativeDialog("Error", Colors.red, "An error occured while fetching the mine data", context);
    // }

  }
}
