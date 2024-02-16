class Mine {
  String mineId;
  String mineLocation;
  String area;
  String price;
  String gpsLatitude;
  String gpsLongitude;
  String timeAdded;
  bool verified ;
  String mineOwner;
  String requestType;
  String requestStatus;

  Mine({
    required this.mineId,
    required this.mineLocation,
    required this.area,
    required this.price,
    required this.gpsLatitude,
    required this.gpsLongitude,
    required this.timeAdded,
    required this.verified,
    required this.mineOwner,
    required this.requestType,
    required this.requestStatus

  });

  factory Mine.fromJson(Map<String, dynamic> json) {
    return Mine(
      mineId: json['mineId'],
      mineLocation: json['mineLocation'],
      area: json['area'],
      price: json['price'],
      gpsLatitude: json['gpsLatitude'],
      gpsLongitude: json['gpsLongitude'],
      timeAdded: json['timeAdded'],
      verified: json['verified'],
      mineOwner: json['mineOwner'],
      requestType: json['requestType'],
      requestStatus: json['requestStatus']
    );
  }
  // to convert the object to a json object
  Map<String, dynamic> toJson() {
    return {
      'mineId': mineId,
      'mineLocation': mineLocation,
      'area': area,
      'price': price,
      'gpsLatitude': gpsLatitude,
      'gpsLongitude': gpsLongitude,
      'timeAdded': timeAdded,
      'verified': verified,
      'mineOwner': mineOwner,
      'requestStatus':requestStatus,
      'requestType':requestType

    };
  }

}