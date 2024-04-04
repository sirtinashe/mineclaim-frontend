import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/request_types.dart';
import 'models/requests.dart';

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
}