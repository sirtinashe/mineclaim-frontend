import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications{
  String title;
  String description;
  Timestamp timeAdded;
  String imageUrl;
  String mineOwner;
  String mineId;

  Notifications({required this.title, required this.description, required this.timeAdded, required this.imageUrl,required this.mineOwner,required this.mineId});

  Map toJson() => {
    'title': title,
    'description': description,
    'timeAdded': timeAdded,
    'imageUrl': imageUrl
  };
  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      title: json['title'].toString(),
      description: json['description'].toString(),
      timeAdded: json['timeAdded'],
      imageUrl: json['imageUrl'].toString(),
        mineOwner: json['mineOwner'].toString(),
        mineId: json['mineId'].toString()
    );
  }
}