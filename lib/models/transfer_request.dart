import 'package:mineclaim/models/request_types.dart';

class TransferRequests{
  String requestType;
  String requestStatus;
  // String requester;
  RequestTypes requestTypes;
  bool verified ;
  String newMineOwner;
  String transferredBy ;
  String mineId ;



  TransferRequests(
      {required this.requestType,
        required this.requestStatus,
        // required this.requester,
        required this.requestTypes,
        required this.verified,
        required this.mineId,
        required this.newMineOwner,
        required this.transferredBy
      });
}