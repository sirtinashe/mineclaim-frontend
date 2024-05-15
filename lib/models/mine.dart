class Mine {
  String mineId;
  String mineLocation;
  String area;
  String gpsLatitude;
  String gpsLongitude;
  String timeAdded;
  String verified ;
  String mineOwner;
  String requestType;
  String requestStatus;
  String claimant;
  String documentUrl;
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
    required this.claimant,
    required this.documentUrl



  });

  factory Mine.fromJson(Map<String, dynamic> json) {
    return Mine(
      mineId: json['mineId'].toString(),
      mineLocation: json['mineLocation'].toString(),
      area: json['area'].toString(),

      gpsLatitude: json['gpsLatitude'].toString(),
      gpsLongitude: json['gpsLongitude'].toString(),
      timeAdded: json['timeAdded'].toString(),
      verified: json['verified'],
      mineOwner: json['mineOwner'].toString(),
      requestType: json['requestType'].toString(),
      requestStatus: json['requestStatus'].toString(),
      claimant: json['claimant'].toString(),
      documentUrl: json['documentUrl'].toString()
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
      'claimant':claimant,
      'documentUrl':documentUrl

    };
  }

}