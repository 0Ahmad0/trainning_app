import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  var name;
  var description;
  var location;
  var rating;
  var email;
  var info;
  var interest;
  var state;
  var image;
  var id;
  Company({this.name, this.description, this.location, this.rating});

  Company.fromJson(Map<String, dynamic> json,var documentId) {
    name = json['name'];
    id =documentId;
    description = json['description'];
    location = json['location'];
    rating = json['rating'];
    info = json['info'];
    interest = json['interest'];
    state = json['state'];
    image = json['image'];
  }
}
