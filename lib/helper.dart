import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/mine.dart';
import 'models/request_types.dart';
import 'models/requests.dart';
import 'models/transfer_request.dart';

class RequestSerializer {
  static  List<Requests> serialize(List<DocumentSnapshot> requests) {

    List<Requests> appRequests = [];

    for(DocumentSnapshot request in requests){


      appRequests.add(Requests(
          requestType: request['requestType'],
          requestStatus: request['requestStatus'],
          requester: request['mineOwner'],
          verified: request['verified'],

          data: {
            "requesterName": request['mineOwner'],
            "mineId": request['mineId'],
            "mineLocation": request['mineLocation'],
            "area": request['area'],
            "claimant": "${request['claimant']}",
          },
          imagePath: request['documentUrl'],
          requestTypes: RequestTypes.ADD_MINE,
      ));
    }

    return appRequests;
  }

  static List<TransferRequests> serializeTransferRequests(List<DocumentSnapshot> requests){

    List<TransferRequests> transferRequests = [];

    for(DocumentSnapshot request in requests){
      transferRequests.add(
        TransferRequests(
            requestType: request['requestType'],
            requestStatus: request['requestStatus'],
            requestTypes: RequestTypes.TRANSFER_OWNERSHIP,

            verified: request['verified'],
            mineId: request['mineId'],
            newMineOwner: request['newMineOwner'],
            transferredBy: request['transferredBy'],

        )
      );
    }

    return transferRequests ;

  }

  static Mine serializeClaimedMines(DocumentSnapshot claimedMine){

    Mine mine = Mine(
        mineId: claimedMine['mineId'],
        mineLocation: claimedMine['mineLocation'],
        area: claimedMine['area'],
        gpsLatitude: claimedMine['gpsLatitude'],
        gpsLongitude: claimedMine['gpsLongitude'],
        timeAdded: claimedMine['timeAdded'],
        verified: claimedMine['verified'],
        mineOwner: claimedMine['mineOwner'],
        requestType: claimedMine['requestType'],
        requestStatus: claimedMine['requestStatus'],
        claimant: claimedMine['claimant'],
        documentUrl: claimedMine['documentUrl']
    );



    return mine ;

  }
}