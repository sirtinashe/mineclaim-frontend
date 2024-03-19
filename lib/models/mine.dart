class Mine {
  String mineId;
  String mineLocation;
  String area;
  String gpsLatitude;
  String gpsLongitude;
  String timeAdded;
  bool verified ;
  String mineOwner;
  String requestType;
  String requestStatus;
  String claimant;

  Mine({
    required this.mineId,
    required this.mineLocation,
    required this.area,
    required this.gpsLatitude,
    required this.gpsLongitude,
    required this.timeAdded,
    required this.verified,
    required this.mineOwner,
    required this.requestType,
    required this.requestStatus,
    required this.claimant


  });

  factory Mine.fromJson(Map<String, dynamic> json) {
    return Mine(
      mineId: json['mineId'],
      mineLocation: json['mineLocation'],
      area: json['area'],

      gpsLatitude: json['gpsLatitude'],
      gpsLongitude: json['gpsLongitude'],
      timeAdded: json['timeAdded'],
      verified: json['verified'],
      mineOwner: json['mineOwner'],
      requestType: json['requestType'],
      requestStatus: json['requestStatus'],
      claimant: json['claimant']
    );
  }
  // to convert the object to a json object
  Map<String, dynamic> toJson() {
    return {
      'mineId': mineId,
      'mineLocation': mineLocation,
      'area': area,

      'gpsLatitude': gpsLatitude,
      'gpsLongitude': gpsLongitude,
      'timeAdded': timeAdded,
      'verified': verified,
      'mineOwner': mineOwner,
      'requestStatus':requestStatus,
      'requestType':requestType,
      'claimant':claimant

    };
  }

}