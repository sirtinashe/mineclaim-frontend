import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mineclaim/models/request_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/requests.dart';

List<Requests> requestData = [
  Requests(
      requestType: "Transfer of Ownership",
      requestStatus: "Pending",
      requester: "1y23526#\$@#",
      verified: false,

      data: {
        "requesterName": "Tinashe Mashaya",
        "mineId": "123456",
        "mineLocation": "334 Dangare Road, Mutare",
        "area": "153 sqm",
        "price": "\$2,200",
      },
      imagePath: 'https://www.researchgate.net/publication/352676417/figure/fig1/AS:1037724651909121@1624424245893/Satellite-location-for-Mimosa-Mine-Source-Google-maps.png',
      requestTypes: RequestTypes.TRANSFER_OWNERSHIP
  ),
  Requests(
    verified: false,
    requester: "Ywsu36KDBRF",
    requestType: "Verify Profile",
    requestStatus: "Pending",
    data: {
      "requesterName": "John Doe",
      "idNumber": "75-538327A74",
      "phoneNumber": "0779319867"
    },
    imagePath: 'https://www.shutterstock.com/image-photo/about-us-adult-african-american-600nw-2257341289.jpg',
    requestTypes: RequestTypes.VERIFY_PROFILE,
  ),
  Requests(
    requestType: "Transfer of Ownership",
    requestStatus: "Pending",
    requester: "YDY3@31344",
      verified: false,
    data: {
      "requesterName": "John Doe",
      "mineId": "123456",
      "mineLocation": "123 Test Road, Testville",
      "area": "12 sqm",
      "price": "\$200",
    }, imagePath: 'https://www.mdpi.com/remotesensing/remotesensing-12-03895/article_deploy/html/images/remotesensing-12-03895-g010-550.jpg',
      requestTypes: RequestTypes.TRANSFER_OWNERSHIP
  ),
  // Add new profile request here

  Requests(
    requester: "Ywsu36KDBRF",
      verified: false,
    requestType: "Verify Profile",
    requestStatus: "Declined",
    data: {
      "requesterName": "John Doe",
      "idNumber": "75-538327A74",
      "phoneNumber": "0779319867"

    },
    imagePath: "https://img.freepik.com/free-photo/close-up-portrait-cheerful-young-black-man-grey-t-shirt-smiling-broadly_273609-430.jpg",
      requestTypes: RequestTypes.VERIFY_PROFILE
  ),
  Requests(
    requester: "Ywsu36KDBRF",
    requestType: "Verify Profile",
    requestStatus: "Approved",
    verified: false,
    data: {
      "requesterName": "John Doe",
      "idNumber": "75-538327A74",
      "phoneNumber": "0779319867"
    },
    imagePath: 'https://www.shutterstock.com/image-photo/key-success-starts-how-you-600nw-2120376728.jpg',
    requestTypes: RequestTypes.VERIFY_PROFILE,
  )
];

String globalUuid = "" ;
// FirebaseFirestore db ;
// final Future<SharedPreferences> sharedPreferences =  SharedPreferences.getInstance() ;

