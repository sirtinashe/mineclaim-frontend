import 'package:mineclaim/models/request_types.dart';

class Requests{
  String requestType;
  String requestStatus;
  String requester;
  Map<String, dynamic> data;
  String imagePath ;
  RequestTypes requestTypes;
  bool verified ;


  Requests({required this.requestType, required this.requestStatus, required this.requester, required this.data,required this.imagePath,required this.requestTypes, required this.verified});
}