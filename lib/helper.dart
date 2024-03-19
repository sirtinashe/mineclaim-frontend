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
          imagePath: 'https://www.researchgate.net/publication/352676417/figure/fig1/AS:1037724651909121@1624424245893/Satellite-location-for-Mimosa-Mine-Source-Google-maps.png',
          requestTypes: RequestTypes.ADD_MINE,
      ));
    }

    return appRequests;
  }
}